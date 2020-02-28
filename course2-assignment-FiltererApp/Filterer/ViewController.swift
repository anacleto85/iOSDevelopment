//
//  ViewController.swift
//  Filterer
//
//  Created by Jack on 2015-09-22.
//  Copyright © 2015 UofT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var originalTitleView: UIView!
    
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var bottomMenu: UIView!
    
    @IBOutlet var filterButton: UIButton!
    
    @IBOutlet var compareButton: UIButton!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var filteredImageView: UIImageView!
    var displayed: UIImage!
    
    var touchBegin: Bool?
    var df: DefaultFilterManager!       // default filter manager reference
    
    // load view
    override func viewDidLoad() {
        super.viewDidLoad()
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.9)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        
        // set the "Original" title view
        originalTitleView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.9)
        originalTitleView.translatesAutoresizingMaskIntoConstraints = false
        // set displayed image
        self.displayed = self.imageView.image
        // show view
        self.showOriginalTitleView()
    
        
        // set the default filter manager
        self.df = DefaultFilterManager()
        // set original image
        self.compareButton.enabled = false
    }
    
    // show original image on touch began - override delegate function
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // check if compare button is enabled
        if self.compareButton.enabled == true &&
            self.displayed == self.filteredImageView.image
        {
            // hide secondary menu
            self.hideSecondaryMenu()
            // display original image
            self.hideFilteredImage()
            self.touchBegin = true
        }
    }
    
    // show back the filtered image on touch end - override delete function
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // check if compare button in enabled
        if self.compareButton.enabled == true &&
            self.displayed == self.imageView.image &&
            self.touchBegin == true
        {
            // display filtered image
            self.showFilteredImage()
            // show secondary menu
            self.showSecondaryMenu()
            // set touch begin false
            self.touchBegin = false
        }
    }

    // MARK: Share
    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: ["Check out our really cool app", imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    // MARK: New Photo
    @IBAction func onNewPhoto(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            // update image view
            self.imageView.image = image
            // hide filtered image if needed
            if self.displayed == self.filteredImageView.image {
                // hide filtered image
                self.hideFilteredImage()
            }
            // update displayed image
            self.displayed = self.imageView.image
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // action on red filter button
    @IBAction func onRedFilter(sender: UIButton) {
        // apply filter
        self.doApplyFilter(FilterNames.RedDiffFilterX5)
    }
    
    // action on green filter button
    @IBAction func onGreenFilter(sender: UIButton) {
        // apply filter
        self.doApplyFilter(FilterNames.GreenDiffFilterX5)
    }
    
    // action on blu filter button
    @IBAction func onBluFilter(sender: UIButton) {
        // apply filter
        self.doApplyFilter(FilterNames.BluDiffFilterX5)
    }
    
    // action on sepia filter button
    @IBAction func onSepiaFilter(sender: UIButton) {
        // apply filter
        self.doApplyFilter(FilterNames.SepiaFilter)
    }
    
    // action on contrast filter button
    @IBAction func onContrastFilter(sender: UIButton) {
        // apply filter
        self.doApplyFilter(FilterNames.ContrastX2)
    }
    
    
    // MARK: Filter Menu
    @IBAction func onFilter(sender: UIButton) {
        if (sender.selected) {
            hideSecondaryMenu()
            sender.selected = false
        } else {
            showSecondaryMenu()
            sender.selected = true
        }
    }
    
    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(55)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.secondaryMenu.alpha = 1.0
        }
        // set button selected
        self.filterButton.selected = true
    }

    func hideSecondaryMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0
            }) { completed in
                if completed == true {
                    self.secondaryMenu.removeFromSuperview()
                    // deselect button
                    self.filterButton.selected = false
                }
        }
    }
    
    // swap filtered image with the original
    @IBAction func onCompare(sender: UIButton) {
        // check displayed image
        if self.displayed == self.filteredImageView.image {
            // hide secondary menu
            self.hideSecondaryMenu()
            // display original image
            self.hideFilteredImage()
        }
        else if self.displayed == self.imageView.image {
            // display filtered image
            self.showFilteredImage()
            // display secondary menu
            self.showSecondaryMenu()
        }
    }
    
    // apply a filter to the image
    func doApplyFilter(filterName: FilterNames) {
        // create filter
        let filter = self.df.lookup(filterName)
        // apply  filter
        var img = RGBAImage(image: self.imageView.image!)!
        filter.apply(&img)
        // set tmp 
        self.filteredImageView.image = img.toUIImage()
        
        // enable compare
        if self.compareButton.enabled == false {
            self.compareButton.enabled = true
        }
        
        // display filtered image if needed
        if (self.displayed == self.imageView.image) {
            // show filtered image
            self.showFilteredImage()
            // hide secondary menu
            self.hideSecondaryMenu()
            // show secondary menu
            self.showSecondaryMenu()
        }
        
        // set displayed image
        self.displayed = self.filteredImageView.image
    }
    
    // function to display the overlaying view with label "Original"
    func showOriginalTitleView() {
        // add view
        view.addSubview(originalTitleView)
        
        // set anchors to correctly display the view
        let topConstraint = originalTitleView.topAnchor.constraintLessThanOrEqualToAnchor(self.imageView.topAnchor, constant: 5)
        let leftConstraint = originalTitleView.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = originalTitleView.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        // set height
        let heightConstraint = originalTitleView.heightAnchor.constraintEqualToConstant(23)
        
        // activate constraints
        NSLayoutConstraint.activateConstraints([
            topConstraint,
            leftConstraint,
            rightConstraint,
            heightConstraint])
        
        view.layoutIfNeeded()
    }

    
    // show filter image
    func showFilteredImage() {
        // add filtered image view
        view.addSubview(filteredImageView)
        
        // set anchors
        let top = filteredImageView.topAnchor.constraintEqualToAnchor(self.imageView.topAnchor)
        let left = filteredImageView.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let right = filteredImageView.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let bottom = filteredImageView.bottomAnchor.constraintEqualToAnchor(self.imageView.bottomAnchor)
        let height = filteredImageView.heightAnchor.constraintEqualToAnchor(self.imageView.heightAnchor)
        
        filteredImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // activate constraints
        NSLayoutConstraint.activateConstraints([
            top, left, right, bottom, height])
        
        view.layoutIfNeeded()
        
        // animated transition
        filteredImageView.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.filteredImageView.alpha = 1
        }
        
        // set displayed image
        self.displayed = self.filteredImageView.image
    }
    
    // hide filtered view and display original image
    func hideFilteredImage() {
        self.filteredImageView.alpha = 1
        UIView.animateWithDuration(0.4, animations: {
            self.filteredImageView.alpha = 0
        }) { completed in
            // check if completed
            if completed == true {
                // hide filtered image view
                self.filteredImageView.removeFromSuperview()
                // update displayed image
                self.displayed = self.imageView.image
            }
        }
    }
}

