//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")!

// Process the image!
//let sampleRGB = RGBAImage(image: image)!

/*
var totalRed = 0
var totalGreen = 0
var totalBlue = 0

for y in 0..<sampleRGB.height {
    for x in 0..<sampleRGB.width {
        let index = y * sampleRGB.width + x
        var pixel = sampleRGB.pixels[index]
        totalRed += Int(pixel.red)
        totalBlue += Int(pixel.blue)
        totalGreen += Int(pixel.green)
    }
}

let count = sampleRGB.width * sampleRGB.height
let avgRed = totalRed/count
let avgGreen = totalGreen/count
let avgBlue = totalBlue/count
*/

let avgRed = 118
let avgGreen = 98
let avgBlue = 83
/*
for y in 0..<sampleRGB.height {
    for x in 0..<sampleRGB.width {
        let index = y * sampleRGB.width + x
        var pixel = sampleRGB.pixels[index]
        let redDiff = Int(pixel.red) - avgRed
        if (redDiff > 0)
        {
            pixel.red = UInt8 ( max(0,min(255, avgRed + redDiff*5)))
        }
        let greenDiff = Int(pixel.green) - avgGreen
        if (greenDiff > 0)
        {
            pixel.green = UInt8 ( max(0,min(255, avgGreen + greenDiff/5)))
        }
        let blueDiff = Int(pixel.blue) - avgBlue
        if (blueDiff > 0)
        {
            pixel.blue = UInt8 ( max(0,min(255, avgBlue + blueDiff*5)))
        }
    }
}


let newImage = sampleRGB.toUIImage()
*/


class Filter {
    var name: String = ""
    var filter: ((Pixel) -> (Pixel))
    
    init(filter: ((Pixel) -> (Pixel)), name: String) {
        self.name = name
        self.filter = filter
    }
}


// Make the removeRedFilter
func removeRed(var pixel: Pixel) -> Pixel {
    pixel.red = 0
    return pixel
}
let removeRedFilter = Filter(filter: removeRed, name: "RemoveRed")


// Make the removeGreenFilter
func removeGreen(var pixel: Pixel) -> Pixel {
    pixel.green = 0
    return pixel
}
let removeGreenFilter = Filter(filter: removeGreen, name: "RemoveGreen")


// Make the removeBlueFilter
func removeBlue(var pixel: Pixel) -> Pixel {
    pixel.blue = 0
    return pixel
}
let removeBlueFilter = Filter(filter: removeBlue, name: "RemoveBlue")


// Make the colorSwapper filter
func swapColor(var pixel: Pixel) -> Pixel {
    let temp = pixel.red
    pixel.red = pixel.blue
    pixel.blue = pixel.green
    pixel.green = temp
    return pixel
}
let colorSwapFilter = Filter(filter: swapColor,name: "SwapColor")


// Make the contrastFilter
func changeContrast(var pixel: Pixel) -> Pixel {
    let redDelta = Int(pixel.red) - avgRed
    let greenDelta = Int(pixel.green) - avgGreen
    let blueDelta = Int(pixel.blue) - avgBlue
    pixel.red = UInt8(max(min(255, avgRed + 5 * redDelta), 0))
    pixel.green = UInt8(max(min(255, avgGreen + 5 * greenDelta), 0))
    pixel.blue = UInt8(max(min(255, avgBlue + 5 * blueDelta), 0))
    return pixel
}
let contrastFilter = Filter(filter: changeContrast, name: "ChangeContrast")



class ImageProcessor {
    var filterList: [Filter] = []
    
    func addFilter(filter: String){
        filterList.append(availableFilters[filter]!)
    }
    
    var availableFilters: [String: Filter] = [
        "removeRedFilter": removeRedFilter,
        "removeGreenFilter": removeGreenFilter,
        "removeBlueFilter": removeBlueFilter,
        "colorSwapFilter": colorSwapFilter,
        "contrastFilter": contrastFilter,
    ]
    
    init() {
        self.addFilter("removeRedFilter")
        self.addFilter("removeGreenFilter")
        self.addFilter("removeBlueFilter")
        self.addFilter("colorSwapFilter")
        self.addFilter("contrastFilter")
    }
    
    func processImage(image: UIImage, name: String) -> UIImage {
        let rgbaImage = RGBAImage(image: image)!
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                let pixel = rgbaImage.pixels[index]
                let filter = availableFilters[name]
                rgbaImage.pixels[index] = filter!.filter(pixel)
            }
        }
        return rgbaImage.toUIImage()!
    }
}

var imageProcessor: ImageProcessor = ImageProcessor()

imageProcessor.processImage(image, name: "removeRedFilter")
imageProcessor.processImage(image, name: "removeGreenFilter")
imageProcessor.processImage(image, name: "removeBlueFilter")
imageProcessor.processImage(image, name: "colorSwapFilter")
imageProcessor.processImage(image, name: "contrastFilter")


