//: Playground - noun: a place where people can play

import UIKit

// Let's talk about heritage by defining an object whichi a subclass of 
// + an existing one. In this way we can "customize" the behaviour of 
// + an existing class for some special purposes
class SuperNumber : NSNumber {
    
    // now we can override some functions
    override func getValue(value: UnsafeMutablePointer<Void>) {
        super.getValue(value);
    }
    
    // define a function
    func hello() -> String {
        return "hello"
    }
}

// extend the an existing class with additional functionalities
extension NSNumber {
    
    func superCoolGetter() -> Int {
        return 5;
    }
}

// create a NSNumber object
let n = NSNumber(int: 4)
// The method is available from the NSNumber class since we have extended the original class
n.superCoolGetter()


// Let's define protocols that are very similar to interfaces. Classes can be 
// + conform to a protocol by implementing its functions
protocol dancable {

    func dance()
}

// Define a Person who can dance
class Person: dancable {
    
    // implement the protocol
    func dance() {
        print("Hello We can dance together");
    }
}

// Create a dancable object
var p:dancable = Person()
p.dance()


// Define veggies as an enumeration of strings
enum TypesOfVeggies : String {
    case Carrots
    case Tomatoes
    case Celery
}

let carrots = TypesOfVeggies.Carrots
carrots.rawValue


func eatVeggies(veggies:TypesOfVeggies) {
    print("eaten")
}

// try to access a not existing enumeration value
let randomVeggies = TypesOfVeggies(rawValue: "Lead")

eatVeggies(TypesOfVeggies.Tomatoes)


// Create a class with a required initializer
class Car {
    
    var cupHolder: String;
    
    required init(cupHolder: String) {
        self.cupHolder = cupHolder;
    }
    
    convenience init() {
        self.init(cupHolder: "Cool")
    }
    
    deinit {
        // clean memory
    }
}

var car1 = Car(cupHolder: "Cool Cool")
car1.cupHolder
var car2 = Car()
car2.cupHolder





