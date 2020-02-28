//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")!

// Process the image!

let myRGBA = RGBAImage(image: image)!
/*
var totalRed = 0
var totalGreen = 0
var totalBlue = 0


//Total number of pixels
for y in 0..<myRGBA.height {
    for x in 0..<myRGBA.width {
        let index = y * myRGBA.width + x
        var pixel = myRGBA.pixels[index]
        totalRed += Int(pixel.red)
        totalGreen += Int(pixel.green)
        totalBlue += Int(pixel.blue)
        
    }
}

//Number of each color of pixels
let count = myRGBA.width * myRGBA.height
let avgRed = totalRed/count
let avgGreen = totalGreen/count
let avgBlue = totalBlue/count
*/

let avgRed = 118
let avgGreen = 98
let avgBlue = 83



class greyscale_filter {
    var result: UIImage {
    for y in 0..<myRGBA.height {
        for x in 0..<myRGBA.width {
            let index = y * myRGBA.width + x
            var pixel = myRGBA.pixels[index]
            let intensity = (Int(pixel.blue) + Int(pixel.green) + Int(pixel.red)) / 3
            let grey = UInt8( max(0,min(255, intensity)))
            pixel.red = grey
            pixel.green = grey
            pixel.blue = grey
            myRGBA.pixels[index] = pixel
        }
        }
    
    return myRGBA.toUIImage()!
    }
}
var newImage = greyscale_filter.init().result

class redboost_filter {
    var result: UIImage{
    for y in 0..<myRGBA.height {
        for x in 0..<myRGBA.width {
            let index = y * myRGBA.width + x
            var pixel = myRGBA.pixels[index]
            let redDiff = Int(pixel.red) - avgRed
                if (redDiff>0)
                {
                    pixel.red = UInt8( max(0,min(255,avgRed + redDiff*3 ) ) )
                    myRGBA.pixels[index] = pixel
                }
            }
        }
        return myRGBA.toUIImage()!
        }
    }
var newImage2 = redboost_filter.init().result


let filters = ["greyscale", "redboost"]
let photos = ["greyscale" : "var newImage = greyscale_filter.init().result", "redboost" : "var newImage2 = redboost_filter.init().result"]

for filter in filters {
    photos [filter]
    
}



