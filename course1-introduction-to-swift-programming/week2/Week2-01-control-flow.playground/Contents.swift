//: Playground - noun: a place where people can play

import UIKit

let name = "Alessandro"

// IF statements
if name.characters.count > 10 {
    print("Long Name")
}
else if name.characters.count > 5 {
    print("Medium Name")
}
else {
    print("Short Name")
}

// SWITCH statements
switch name.characters.count {

// case where string name lenght is in [7, 10]
case 7...10 :
    print("Long name");

// case where name length is in [5, 7)
case 5..<7 :
    print ("Medium name");
    
default :
    print("some length");
}


// WHILE statements
var number = 0;
while number < 10 {
    number * number
    number++
}

// FOR statemnets
for (var number = 0; number < 10; number++) {
    number
}


for number in 0..<10 {
    number
}

for number in [2,5,4,6,7,2,3] {
    number
}

