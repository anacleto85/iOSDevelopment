//: Playground - noun: a place where people can play

import UIKit

func doMath() {
    print("Doing Math");
}


doMath()

var a = 10
var b = 11

func doMath(a:Double, b:Double, operation:String) {
    print("Performing  operation ", operation, " on ", a, " and ", b)
}
// the first parameter is labed by the name of the function
doMath(2.0, b:2.0, operation:"+")

// define functions with labels
func perform(operation:String, on a:Double, and b:Double) {
    print("Performing  operation ", operation, " on ", a, " and ", b)
}
// labels improve the expressivenes of the code - we can use them instead of "local" variables
perform("+", on:1.0, and:2.0);

a + b


// functions with returning variables
func doPerform(operation:String, on a:Double, and b:Double) -> Double {
    var result:Double = 0
    print("Performing  operation ", operation, " on ", a, " and ", b)
    // check operation
    switch operation {
        case "+" :  result = a + b
        case "-" : result = a - b
        case "*" : result = a * b
        case "/" : result = a / b
        default : print("Bad operation ", operation);
    }
    // get the rusult
    return result
}

let result = doPerform("/", on:2.0, and:3.0)
