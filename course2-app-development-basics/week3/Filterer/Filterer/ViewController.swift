//
//  ViewController.swift
//  Filterer
//
//  Created by Alessandro Umbrico on 14/03/16.
//  Copyright © 2016 Slump. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var filteredImage: UIImage?

    @IBOutlet var imgView: UIImageView!
    
    @IBOutlet var imgButton: UIButton!
    
    // handle onClick button event
    @IBAction func onClickToggleButton(sender: UIButton) {
        // check if botton is selected
        if (imgButton.selected) {
            // show original image
            let original = UIImage(named: "sample")!
            imgView.image = original
            imgButton.selected = false
        }
        else {
            // show filtered image
            self.imgView.image = self.filteredImage
            imgButton.selected = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let image = UIImage(named: "sample")!
        
        let rgbaImage = RGBAImage(image: image)!

        let avgRed = 107
        
        // process pixels
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                // get current pixel
                var pixel = rgbaImage.pixels[index]
                
                let redDelta = Int(pixel.red) - avgRed
                
                var modifier = 1 + 4 * (Double(y) / Double(rgbaImage.height))
                if (Int(pixel.red) < avgRed) {
                    modifier = 1
                }
                
                // update pixel's red value
                pixel.red = UInt8(max(min(255,
                    Int(round(Double(avgRed) + modifier * Double(redDelta)))), 0))
                // update image's pixel
                rgbaImage.pixels[index] = pixel
            }
        }
        
        self.filteredImage = rgbaImage.toUIImage()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

