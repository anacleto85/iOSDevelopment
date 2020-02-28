//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")

// Raw filters
let imgRawFilters = ImageProcessor(image: image!)
imgRawFilters.brightness(1).contrast(1).alpha(80).toUIImage()

// Predefined Filters
let imgPredefinedFilters = ImageProcessor(image: image!)
// possible values: colorRed, colorGreen, colorBlue, halfAlpha, halfBrightness
imgPredefinedFilters.predefinedFilters(["colorRed","halfAlpha"])

