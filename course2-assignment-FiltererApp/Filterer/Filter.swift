import Foundation
import UIKit

/*
 * Filter protocol
 */
public protocol FilterProtocol {
    
    /*
     * Apply a filter function to an image
     */
    func apply(inout img:RGBAImage)
    
    /*
     * Apply a filter function to a specific pixel
     */
    func apply(inout pixel:Pixel)
    
}

/*
 * A general Filter class
 */
public class Filter : FilterProtocol {
    
    init() {}
    
    public func apply(inout img:RGBAImage) {
        // apply filter function to all pixels
        for y in 0..<img.height {
            for x in 0..<img.width {
                // get current pixel
                let index = y * img.width + x
                
                // apply filter
                self.apply(&img.pixels[index])
            }
        }
    }
    
    public func apply(inout pixel: Pixel) {
        preconditionFailure("This function must be overridden")
    }
}

/*
 * Contrast filter
 *
 * The parameter lambda represents the value of contrast 
 * desired and it must in the range [-255, +255]
 */
public class ContrastFilter : Filter {

    var contrast: Int
    var factor:Double {
        get {
            // compute the contrast factor
            return Double(259 * (self.contrast + 255)) / Double(255 * (259 - self.contrast))
        }
    }
    
    // create a filter with the specified parameter
    public init(contrast: Int) {
        // set the desired contrast level
        self.contrast = contrast
    }

    // apply brightness filter to a specific pixel of an image
    override public func apply(inout pixel: Pixel) {
        // get color parameters
        let red = Int(pixel.red)
        let green = Int(pixel.green)
        let blue =  Int(pixel.blue)
        
        let dred = self.factor * Double(red - 128) + 128
        let dgreen = self.factor * Double(green - 128) + 128
        let dblue = self.factor * Double(blue - 128) + 128
        
        // apply function
        pixel.red = UInt8(max(0, min(255, dred)))
        pixel.green = UInt8(max(0, min(255, dgreen)))
        pixel.blue = UInt8(max(0, min(255, dblue)))
    }
}

/*
 * Brightness filter
 * 
 * The parameter of the constructor represents the value of 
 * brightness desired and it must be in the range [-255, 255]
 */
public class BrightnessFilter : Filter {
    
    var brightness: Int
    
    // create a filter with the specified parameter
    required public init(brightness: Int) {
        // set the desired level of brightness
        self.brightness = brightness
    }
    
    // apply brightness filter to a specific pixel of an image
    override public func apply(inout pixel: Pixel) {
        // get color parameters
        let red = Int(pixel.red)
        let green = Int(pixel.green)
        let blue = Int(pixel.blue)
        
        // apply function
        pixel.red = UInt8(max(0, min(255, red + self.brightness)))
        pixel.green = UInt8(max(0, min(255, green + self.brightness)))
        pixel.blue = UInt8(max(0, min(255, blue + self.brightness)))
    }
}

/*
 * Red diff filter
 */
public class RedDiffFilter : Filter {
    
    let lambda: Int
    var avgRed: Int
    
    // create a filter with the specified parameter
    required public init(lambda: Int) {
        // set lambda
        self.lambda = lambda
        self.avgRed = 0
    }
    
    // override function
    override public func apply(inout img: RGBAImage) {
        // compute average red of the picture
        var tot = 0
        for y in 0..<img.height {
            for x in 0..<img.width {
                let index = y * img.width + x
                let pixel = img.pixels[index]
                
                tot += Int(pixel.red)
            }
        }
        
        // number of pixels
        let count = img.width * img.height
        // compute average
        self.avgRed = tot/count
        
        // apply filter
        super.apply(&img)
    }
    
    // apply brightness filter to a specific pixel of an image
    override public func apply(inout pixel: Pixel) {
        // check diff
        let diff = Int(pixel.red) - self.avgRed
        if (diff > 0) {
            pixel.red = UInt8(max(0, min(255, self.avgRed + diff * lambda)))
        }
    }
}

/*
 * Green diff filter
 */
public class GreenDiffFilter : Filter {
    
    let lambda: Int
    var avgGreen:Int
    
    // create a filter with the specified parameter
    required public init(lambda: Int) {
        // set lambda
        self.lambda = lambda
        self.avgGreen = 0
    }
    
    // override function
    override public func apply(inout img: RGBAImage) {
        // compute average red of the picture
        var tot = 0
        for y in 0..<img.height {
            for x in 0..<img.width {
                let index = y * img.width + x
                let pixel = img.pixels[index]
                
                tot += Int(pixel.green)
            }
        }
        
        // number of pixels
        let count = img.width * img.height
        // compute average
        self.avgGreen = tot/count
        
        // apply filter
        super.apply(&img)
    }
    
    // apply brightness filter to a specific pixel of an image
    override public func apply(inout pixel: Pixel) {
        // check diff
        let diff = Int(pixel.green) - self.avgGreen
        if (diff > 0) {
            pixel.green = UInt8(max(0, min(255, self.avgGreen + diff * self.lambda)))
        }
    }
}


/*
 * Blue diff filter
 */
public class BlueDiffFilter : Filter {
    
    let lambda: Int
    var avgBlue:Int
    
    // create a filter with the specified parameter
    required public init(lambda: Int) {
        // set lambda
        self.lambda = lambda
        self.avgBlue = 0
    }
    
    // override function
    override public func apply(inout img: RGBAImage) {

        // compute average red of the picture
        var tot = 0
        for y in 0..<img.height {
            for x in 0..<img.width {
                let index = y * img.width + x
                let pixel = img.pixels[index]
                
                tot += Int(pixel.blue)
            }
        }
        
        // number of pixels
        let count = img.width * img.height
        // compute average
        self.avgBlue = tot/count
        
        // apply filter
        super.apply(&img)
    }
    
    // apply brightness filter to a specific pixel of an image
    override public func apply(inout pixel: Pixel) {
        // check diff
        let diff = Int(pixel.blue) - self.avgBlue
        if (diff > 0) {
            pixel.blue = UInt8(max(0, min(255, self.avgBlue + diff * self.lambda)))
        }
    }
}

/*
 * Sepia filter
 */
public class SepiaFilter : Filter {
    
    override public init() {}
    
    // apply black and white filter to a specific pixel
    override public func apply(inout pixel: Pixel) {
        // get components
        let red = Double(pixel.red)
        let green = Double(pixel.green)
        let blue = Double(pixel.blue)
        
        // set every pixel color component to average
        pixel.red = UInt8(max(0, min(255, (red * 0.393) + (green * 0.769) + (blue * 0.189))))
        pixel.green = UInt8(max(0, min(255, (red * 0.349) + (green * 0.686) + (blue * 0.168))))
        pixel.blue = UInt8(max(0, min(255, (red * 0.272) + (green * 0.534) + (blue * 0.131))))
    }
}
