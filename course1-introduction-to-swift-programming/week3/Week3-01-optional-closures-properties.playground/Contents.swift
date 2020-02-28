//: Playground - noun: a place where people can play

import UIKit

// Optional variable means that the variable can be of the declared 
// + type (e.g. String) or not.
// Namely the value of the variable can be a String or "nil"
var str:String? = "Hello, optional"

// When accessing the value of an optional variable we must enforce
// + its type by using the "!" after the name
str!.characters.count


func performSpell(spell: String) -> String {
    return spell
}

performSpell("disappear")

// Closure of a function
let magic = performSpell

magic("disappear")

// Other example of closure of function
var newMagic = {
    (spell: String) -> String in
    return spell
}

newMagic("appear")


// Create a struct with properties
struct Animal {

    // declare a lazy stored property
    lazy var name:String = ""
    // declare a stored property
    var heightInches = 0.0
    // declare a computed property
    var heightCM: Double {
        get {
            return 2.54 * heightInches
        }
        set (newHeightCM) {
            heightInches = newHeightCM / 2.54
        }
    }
}

var dog = Animal(name: "fuffy", heightInches: 50)
dog.heightInches
dog.heightCM

dog.name
dog.heightCM = 254
dog.heightInches


struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    
    var origin = Point()
    
    var size = Size()
    
    var center:Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set (newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}


var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10))

let initialSquareCenter = square.center


square.center = Point(x: 15.0, y: 15.0)


print("square.origin is now at (\(square.origin.x), \(square.origin.y))")



let wrapped: Int? = nil




