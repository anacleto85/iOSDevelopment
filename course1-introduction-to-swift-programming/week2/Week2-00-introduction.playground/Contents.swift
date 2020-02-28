//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// this declaration is wrong because the variable must 
// + always be a stirng
//--- str = nil;

// the value "nil" does not refer to a null string but it means that
// + it could be anything (event an integer or any other type).
// Thus when we declare a variable as a string (or the compilre infers
// + its type to be a String) we can't say the variable something
// + differnet

// optional variable - it means that it could not be a string
var sstr:String? = "pippo"
// in this case it is possible to assign "nil" to the variable
sstr = nil
sstr = "Hello"

// declare a variable as constant
let constantString = "Bella"
// because it is a constant it is not possible to change its value
//--- constantString = "Zio"

print(constantString)

