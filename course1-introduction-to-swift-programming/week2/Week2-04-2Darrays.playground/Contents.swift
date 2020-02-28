//: Playground - noun: a place where people can play

import UIKit

// define a 2D array representing an image
var image = [
    [3, 7, 10],
    [6, 4, 2],
    [8, 5, 2]
]

// define a function which processes this image in a certain way
func raiseLowerValuesOfImage(inout image:[[Int]]) {
    // take any low value (e.g. less then 5) and raise its value
    for row in 0..<image.count {
        for col in 0..<image[row].count {
            let pixel = image[row][col]
            // check pixel value
            if pixel < 5 {
                image[row][col] = 5
            }
        }
    }
    image
}

// if the parameter of a function is specified as "var" then the parameter
// + is passed to the function by value. Thus the function works on a "private" 
// + copy of the parameter
// Instead if we specify a parameter of a function with "inout" we are saying that
// + the parameter is passed by reference. Thus when the function is called we 
// + must specify a pointer to the data structure


// pass the reference to the image (i.e. a data structure) by specifying 
// + its address like in C programming
raiseLowerValuesOfImage(&image)

// see if the "original" image is changed
image











