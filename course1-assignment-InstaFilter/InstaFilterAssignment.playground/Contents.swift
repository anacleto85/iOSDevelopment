//: Playground - noun: a place where people can play

import UIKit

var image = UIImage(named: "sample")!

// Process the image!

var img1 = RGBAImage(image: image)!
var f1:Filter = ContrastFilter(contrast: -80)
f1.apply(&img1)
img1.toUIImage()


var img2 = RGBAImage(image: image)!
var f2:Filter = BrightnessFilter(brightness: 55)
f2.apply(&img2)
img2.toUIImage()

var img3 = RGBAImage(image: image)!
var f3:Filter = RedDiffFilter(lambda: 3)
f3.apply(&img3)
img3.toUIImage()


// create image processor
let processor = ImageProcessor(source: &image)
// apply a list of filters
var result = processor.process([f1,f2,f3])


// apply the same list of filters in differnt order
result = processor.process([f2,f3,f1])

// apply a list of filters
result = processor.process([BrightnessFilter(brightness: -78), ContrastFilter(contrast: 128), GreenDiffFilter(lambda: 2)])



// apply a list of default filters
result = processor.process([FilterNames.SepiaFilter, FilterNames.ContrastX2])

// apply a single default filter through image processor
result = processor.process(FilterNames.SepiaFilter)

// access default filter management interface
var m = DefaultFilterManager()
var df = m.lookup(FilterNames.Contrast50p)
var img = RGBAImage(image: image)!
// apply default filter to the image
df.apply(&img3)
img3.toUIImage()


