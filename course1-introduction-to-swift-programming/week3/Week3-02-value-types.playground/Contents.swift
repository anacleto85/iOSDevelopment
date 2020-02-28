//: Playground - noun: a place where people can play

import UIKit

var a = 3

var b = a

b = 5

a

class number {
    var n: Int = 0
    
    init(n: Int) {
        self.n = n
    }
}

// create a number
var c = number(n:3)
// Pass the reference of object in c to d
var d = c

c.n
d.n

// Change the value of the number
c.n = 10
// Change also the value of the object referenced by d because the assignment before
// + pass the reference to the target object
c.n
d.n

// structs behave differntly from objects
struct valueNumber {
    var n: Int;
    
    init(n: Int) {
        self.n = n;
    }
}

var e = valueNumber(n:3);
e.n;
// Copy the value of e (i.e. the struct) in the variable f
var f = e;
f.n

e.n = 11
// In this case being a struct, the assignment copy the complex type like "primitive types"
// Thus the assignement before "var f = e" pass the value of e i.e. a copy of the struct
e.n
f.n







