import Foundation
import UIKit

public class ImageProcessor: NSObject {
    
    var totalRed = 0
    var totalGreen = 0
    var totalBlue = 0
    var pixelCount = 0
    var avgRed = 0
    var avgGreen = 0
    var avgBlue = 0
    var _image:RGBAImage?
    
    public init(image: UIImage) {
        
        super.init()
        
        let myRGBAImage = RGBAImage(image: image)!
        
        pixelCount = myRGBAImage.width * myRGBAImage.height

        self._image = myRGBAImage
        
        sampleImage()
    }
    
    func sampleImage() {
   
        for y in 0..<_image!.height {
            for x in 0..<_image!.width {
                let index = y * _image!.width + x
                var pixel = _image!.pixels[index]
                totalRed += Int(pixel.red)
                totalGreen += Int(pixel.green)
                totalBlue += Int(pixel.blue)
            }
        }
        
        avgRed = totalRed/pixelCount
        avgGreen = totalGreen/pixelCount
        avgBlue = totalBlue/pixelCount
   
    }
    
    public func predefinedFilters(filters: [String]) ->  UIImage{
        
        for filter in filters {
            switch filter {
                case "colorRed":
                    self.color("red")
                case "colorGreen":
                    self.color("green")
                case "colorBlue":
                    self.color("blue")
                case "halfAlpha":
                    self.alpha(50)
                case "halfBrightness":
                    self.brightness(2)
                default:
                    break
            }
        }
        
        return (self._image?.toUIImage())!
        
    }
    
    public func toUIImage() ->  UIImage{
        
        return (self._image?.toUIImage())!
        
    }

    public func contrast(contrast: Int) -> ImageProcessor {
        
        for y in 0..<_image!.height {
            for x in 0..<_image!.width {
                let index = y * _image!.width + x
                var pixel = _image!.pixels[index]
                let redDelta = Int(pixel.red) - avgRed
                let greenDelta = Int(pixel.green) - avgGreen
                let blueDelta = Int(pixel.blue) - avgBlue
                pixel.red = UInt8(max(min(255, avgRed + contrast * redDelta), 0))
                pixel.green = UInt8(max(min(255, avgGreen + contrast * greenDelta), 0))
                pixel.blue = UInt8(max(min(255, avgBlue + contrast * blueDelta), 0))
                _image!.pixels[index] = pixel
            }
        }

        return self
        
    }
    
    public func alpha(alpha: UInt8) -> ImageProcessor {
        
        for y in 0..<_image!.height {
            for x in 0..<_image!.width {
                let index = y * _image!.width + x
                var pixel = _image!.pixels[index]
                pixel.alpha = alpha
                _image!.pixels[index] = pixel
            }
        }
        
        return self
        
    }
    
    public func color(type: String) -> ImageProcessor {
        
        for y in 0..<_image!.height {
            for x in 0..<_image!.width {
                let index = y * _image!.width + x
                var pixel = _image!.pixels[index]
                
                switch type {
                    case "red":
                        pixel.red = 255
                    case "green":
                        pixel.red = 45
                    case "blue":
                        pixel.blue = 255
                    default:
                        break
                }
                
                _image!.pixels[index] = pixel
                
            }
        }
        
        return self
        
    }
    
    public func brightness(value: Int) -> ImageProcessor {
        
        for y in 0..<_image!.height {
            for x in 0..<_image!.width {
                
                let index = y * _image!.width + x
                var pixel = _image!.pixels[index]
                pixel.red = UInt8(max(min(255, Int(pixel.red) * value), 0))
                pixel.green = UInt8(max(min(255, Int(pixel.green) * value), 0))
                pixel.blue = UInt8(max(min(255, Int(pixel.blue) * value), 0))
  
                _image!.pixels[index] = pixel
                
            }
        }
        
        return self
        
    }
}