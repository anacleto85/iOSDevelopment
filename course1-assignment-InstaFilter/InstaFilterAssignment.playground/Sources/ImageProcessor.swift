import Foundation
import UIKit

/*
 * Enumeration of predefined filters
 */
public enum FilterNames {
    
    // 2 times contrast filter
    case ContrastX2
    
    // 50% contrast filter
    case Contrast50p
    
    // 2 times brightness filter
    case BrightnessX2
    
    // 50% brightness filter
    case Brightness50p
    
    // sepia filter
    case SepiaFilter
    
    // 5 times red difference filter
    case RedDiffFilterX5
}


/*
 * Element responsible for creating and managing default filters
 */
public struct DefaultFilterManager {
    
    var predefinedFilters:[FilterNames:Filter]
    
    // initialize manager by creatng predefined filters
    public init() {
        // create predefined filters
        self.predefinedFilters = [FilterNames.Brightness50p : BrightnessFilter(brightness: -128),
            FilterNames.BrightnessX2 : BrightnessFilter(brightness: 128),
            FilterNames.SepiaFilter : SepiaFilter(),
            FilterNames.Contrast50p : ContrastFilter(contrast: -128),
            FilterNames.ContrastX2 : ContrastFilter(contrast: 128),
            FilterNames.RedDiffFilterX5 : RedDiffFilter(lambda: 5)]
    }
    
    // get a predefined filter
    public func lookup(name:FilterNames) -> Filter {
        return self.predefinedFilters[name]!
    }
}


/* 
 * Image processor responsible for managing image processing by means of filters
 *
 */
public struct ImageProcessor {
    
    let source:UIImage
    let dfm:DefaultFilterManager


    // create image processor
    public init(inout source: UIImage) {
        // get source image
        self.source = source
        // get default filter manager
        self.dfm = DefaultFilterManager()
    }
    
    /*
     * Process the related image by apply the list of filters specified
     */
    public func process(filters:[Filter?]) -> UIImage {

        // get image to process
        var img:RGBAImage = RGBAImage(image: self.source)!
        
        // setup pipeline
        let pipeline = PipelineFilter(filters: filters)
        // apply pipeline
        pipeline.apply(&img)
    
        // get processed image
        return img.toUIImage()!
    }
    
    /*
    * Process the image by applying the predefined filter selected
    */
    public func process(name: FilterNames) -> UIImage {
        // get filter
        let f = self.dfm.lookup(name)
        return self.process([f])
    }
    
    /*
     * Process the image by applying the list of predefined filters specified
     */
    public func process(names:[FilterNames]) -> UIImage {
        let size = names.count
        var filters = [Filter?](count: size, repeatedValue: nil)
        for i in 0..<size {
            // add a filter
            filters[i] = self.dfm.lookup(names[i])
        }
        
        return self.process(filters)
    }
}

/*
 * Composite filter which applies a list of filters to an image
 *
 * see Composite design pattern
 */
class PipelineFilter : Filter {
    
    var filters:[Filter?]
    
    // create a pipeline of filters
    init(filters:[Filter?]) {
        self.filters = filters
    }
    
    override func apply(inout pixel: Pixel) {
        for index in 0..<filters.count {
            // get current filter to apply
            let f = self.filters[index]!
            f.apply(&pixel)
        }
    }
}
