//
//  main.swift
//  ObjCInterop
//
//  Created by Florent Vilmart on 18-05-10.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import Foundation
import CoreLocation

print("Hello, World!")

let array = ["1", "2", "3"]

func objectAfter<T>(array: [T], object: T) -> T? where T: Equatable {
    if let idx = array.index(of: object),
        let next = array.index(idx, offsetBy: 1, limitedBy: array.count - 1) {
        let c = array.suffix(from: idx)
        return array[next]
    }
    return nil
}

let recipe = Recipe(steps: [])
let manager = RecipeCookingManager(recipe: recipe)

let firstStep = manager.start()
firstStep.complete()

class AutomatedCooker: NSObject, RecipeCookingManagerDelegate {
    func cook(recipe: Recipe) {
        let manager = RecipeCookingManager(recipe: recipe)
        manager.delegate = self // self is a RecipeCookingManagerDelegate
        manager.start() // start cooking the first step should be in progress!
        /* complete all steps */
        recipe.steps.forEach { $0.complete()
        }
        // the did cook method should have been be called!
    }
    func manager(_ manager: RecipeCookingManager, didCook recipe: Recipe) {
        // We're done!
    }
    func manager(_ manager: RecipeCookingManager, didCancel recipe: Recipe)
    {
        // The user cancelled
    }
    func manager(_ manager: RecipeCookingManager, didComplete recipe: Recipe) {

    }

}

let a = objectAfter(array: array, object: "1")
let b = objectAfter(array: array, object: "3")


let obj = MyClass()
//let b = obj.sayHello()
//let c = obj.child()
//let d = c.child()

//c.untypedArray() is [Any]
//c.stringArray() is [String]
//c.kindofStringArray() is [String]
//// obj.append(nil, with: nil)
//print("\(b.appending("yolo"))")



let generic = MyGeneric<NSNumber>()

assert(generic.untypedArray() is [Any])
assert(generic.stringArray() is [String])
assert(generic.kindofStringArray() is [String])
assert(generic.genericArray is [NSNumber]?)


//@objc(FVMovie)
//class Movie: NSObject {
//    let title: String
//    let director: String
//    let year: Int
//    /*
//     Initializers
//     */
//}

extension String {
    static let padCharacter = ""
    func leftPad(to length: Int, with character: String = .padCharacter) -> String {
        fatalError()
    }
}

@objc
extension NSString {
    @objc(flv_leftPadToLength:)
    func leftPad(to length: Int) -> String {
        return (self as String).leftPad(to: length)
    }
    // @objc(flv_leftPad)
    @objc(flv_leftPadToLength:withCharacter:)
    func leftPad(to length: Int, with character: String = String.padCharacter) -> String {
        return (self as String).leftPad(to: length, with: character)
    }
}

Measure(cups: 10)
Measure(amount: 10, unit: MeasureUnit.cups)
    .in(unit: .l)

class LocationAware: NSObject {
    let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
    }
}

extension LocationAware: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // do something with the updated location
    }

    /* more delegation methods */
}

