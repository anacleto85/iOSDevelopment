//: Playground - noun: a place where people can play

import UIKit
/*
let image = UIImage(named: "sample")!

// Process the image!

let myRGBA = RGBAImage(image: image)!

var thisPixel = myRGBA.pixels[0]
thisPixel.red
thisPixel.green
thisPixel.blue
thisPixel.alpha


var totalRed = 0
var totalGreen = 0
var totalBlue = 0
var totalAlpha = 0

for y in 0..<myRGBA.height{
    for x in 0..<myRGBA.width{
        let index = y * myRGBA.width + x
        var pixel = myRGBA.pixels[index]
        
        totalRed += Int(pixel.red)
        totalGreen += Int(pixel.green)
        totalBlue += Int(pixel.blue)
        totalAlpha += Int(pixel.alpha)
    }
}


let count = myRGBA.width * myRGBA.height
let avgRed = totalRed/count
let avgGreen = totalGreen/count
let avgBlue = totalBlue/count
let avgAlpha = totalAlpha/count
*/

let originalImage = UIImage(named: "sample")!
let OriginalmyRGBA = RGBAImage(image: originalImage)!

let avgRed = 118
let avgGreen = 98
let avgBlue = 83



var rederValue = [Int]()
for x in -10...10 {
    rederValue.append(x)
}

func valueNTenToTen(value:Int) -> Int? {
    for x in rederValue {
        if value == x {
            return value
        }
    }
    return nil
}

class InstaFilterProcessor {
    func Reder(value:Int) -> UIImage?{
        let image = UIImage(named: "sample")!
        let myRGBA = RGBAImage(image: image)!
        
        var finalValue:Int? = nil
        finalValue = valueNTenToTen(value)
        let score = 1 + (Double(finalValue!) * 0.06)
        score
        for y in 0..<myRGBA.height{
            for x in 0..<myRGBA.width{
                let index = y * myRGBA.width + x
                var pixel = myRGBA.pixels[index]
                if (Int(pixel.red)>avgRed){
                    pixel.red = UInt8( max(0,min(255,Int(Double(pixel.red) * score))))
                    //idk why min 255
                    myRGBA.pixels[index] = pixel
                }
            }
        }
        let newImageReder = myRGBA.toUIImage()
        return newImageReder!
    }
    
    func Greener(value:Int) -> UIImage?{
        let image = UIImage(named: "sample")!
        let myRGBA = RGBAImage(image: image)!
        
        var finalValue:Int? = nil
        finalValue = valueNTenToTen(value)
        let score = 1 + (Double(finalValue!) * 0.06)
        score
        for y in 0..<myRGBA.height{
            for x in 0..<myRGBA.width{
                let index = y * myRGBA.width + x
                var pixel = myRGBA.pixels[index]
                if (Int(pixel.green)>avgGreen){
                    pixel.green = UInt8( max(0,min(255,Int(Double(pixel.green) * score))))
                    //idk why min 255
                    myRGBA.pixels[index] = pixel
                }
            }
        }
        let newImageReder = myRGBA.toUIImage()
        return newImageReder!
    }
    
    func Bluer(value:Int) -> UIImage?{
        let image = UIImage(named: "sample")!
        let myRGBA = RGBAImage(image: image)!
        
        var finalValue:Int? = nil
        finalValue = valueNTenToTen(value)
        let score = 1 + (Double(finalValue!) * 0.06)
        score
        for y in 0..<myRGBA.height{
            for x in 0..<myRGBA.width{
                let index = y * myRGBA.width + x
                var pixel = myRGBA.pixels[index]
                if (Int(pixel.blue)>avgBlue){
                    pixel.blue = UInt8( max(0,min(255,Int(Double(pixel.blue) * score))))
                    //idk why min 255
                    myRGBA.pixels[index] = pixel
                }
            }
        }
        let newImageReder = myRGBA.toUIImage()
        return newImageReder!
    }
    func Transparency(value:Int) -> UIImage?{
        let image = UIImage(named: "sample")!
        let myRGBA = RGBAImage(image: image)!
        
        var finalValue:Int? = nil
        finalValue = valueNTenToTen(value)
        let score = (Double(finalValue!) * 25.5)
        score
        for y in 0..<myRGBA.height{
            for x in 0..<myRGBA.width{
                let index = y * myRGBA.width + x
                var pixel = myRGBA.pixels[index]
                pixel.alpha = UInt8( max(0,min(255,Int(Double(pixel.alpha) - score))))
                myRGBA.pixels[index] = pixel
            }
        }
        let newImageReder = myRGBA.toUIImage()
        return newImageReder!
    }
    func Brightness(value:Int) -> UIImage?{
        let image = UIImage(named: "sample")!
        let myRGBA = RGBAImage(image: image)!
        
        var finalValue:Int? = nil
        finalValue = valueNTenToTen(value)
        let score = 1 + (Double(finalValue!) * 0.06)
        score
        for y in 0..<myRGBA.height{
            for x in 0..<myRGBA.width{
                let index = y * myRGBA.width + x
                var pixel = myRGBA.pixels[index]
                if (Int(pixel.red)>avgRed){
                    pixel.red = UInt8( max(0,min(255,Int(Double(pixel.red) * score))))
                    //idk why min 255
                    myRGBA.pixels[index] = pixel
                }
                if (Int(pixel.green)>avgGreen){
                    pixel.green = UInt8( max(0,min(255,Int(Double(pixel.green) * score))))
                    //idk why min 255
                    myRGBA.pixels[index] = pixel
                }
                if (Int(pixel.blue)>avgBlue){
                    pixel.blue = UInt8( max(0,min(255,Int(Double(pixel.blue) * score))))
                    //idk why min 255
                    myRGBA.pixels[index] = pixel
                }
                
            }
        }
        let newImageReder = myRGBA.toUIImage()
        return newImageReder!
    }
    func Contrast(value:Int) -> UIImage?{
        let image = UIImage(named: "sample")!
        let myRGBA = RGBAImage(image: image)!
        
        var finalValue:Int? = nil
        finalValue = valueNTenToTen(value)
        let score = 1 + (Double(finalValue!) * 0.06)
        score
        for y in 0..<myRGBA.height{
            for x in 0..<myRGBA.width{
                let index = y * myRGBA.width + x
                var pixel = myRGBA.pixels[index]
                if (Int(pixel.red)>avgRed){
                    pixel.red = UInt8( max(0,min(255,Int(Double(pixel.red) * score))))
                    //idk why min 255
                    myRGBA.pixels[index] = pixel
                }
                if (Int(pixel.red)<avgRed){
                    pixel.red = UInt8( max(0,min(255,Int(Double(pixel.red) / score))))
                    //idk why min 255
                    myRGBA.pixels[index] = pixel
                }
                if (Int(pixel.green)>avgGreen){
                    pixel.green = UInt8( max(0,min(255,Int(Double(pixel.green) * score))))
                    //idk why min 255
                    myRGBA.pixels[index] = pixel
                }
                if (Int(pixel.green)<avgGreen){
                    pixel.green = UInt8( max(0,min(255,Int(Double(pixel.green) / score))))
                    //idk why min 255
                    myRGBA.pixels[index] = pixel
                }
                if (Int(pixel.blue)>avgBlue){
                    pixel.blue = UInt8( max(0,min(255,Int(Double(pixel.blue) * score))))
                    //idk why min 255
                    myRGBA.pixels[index] = pixel
                }
                if (Int(pixel.blue)<avgBlue){
                    pixel.blue = UInt8( max(0,min(255,Int(Double(pixel.blue) / score))))
                    //idk why min 255
                    myRGBA.pixels[index] = pixel
                }
                
            }
        }
        let newImageReder = myRGBA.toUIImage()
        return newImageReder!
    }
}



var InstaFilter = InstaFilterProcessor()
originalImage
//InstaFilter.Bluer(-5)

var img1 = InstaFilter.Bluer(0)

//InstaFilter.Transparency(5)
var img2 = InstaFilter.Greener(5)






