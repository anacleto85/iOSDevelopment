//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// iterate over an array
for number in [2,5,7,23,3,34] {
    number
}

// define an array
var animals = ["cow", "dog", "bunny"]
// define an array with explicit declaration of type
let elements:[String] = ["bottle", "chair", "glass"]

// access elements of an array and change its value
animals[2] = "rabbity"

animals

// enumerate elements fo an array
for animal in animals {
    animal
}

// dictionary data structure
var cuteness = ["cow" : "not very",
                "dog" : "cute",
                "bunny" : "very cute"]

// access an element of the dictionary (by key)
let dogcuteness = cuteness["dog"]

// use the array to index the dictionary
for animal in animals {
    cuteness[animal]
}

