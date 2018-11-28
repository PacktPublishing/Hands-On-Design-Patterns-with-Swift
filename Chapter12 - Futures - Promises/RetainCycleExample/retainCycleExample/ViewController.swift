//
//  ViewController.swift
//  RetainCycleExample
//
//  Created by sergio on 09/11/2018.
//  Copyright © 2018 Freescapes Labs. All rights reserved.
//

import UIKit

class OperationJuggler {
    
    private var operations : [() -> Void] = []
    var delay = 1.0
    
    var name = ""
    
    init(name: String) {
        self.name = name
    }
    
    func addOperationAndCreateRetainCycle(op: (@escaping ()->Void)) {
        self.operations.append { () in
            DispatchQueue.global().asyncAfter(deadline: .now() + self.delay) {
                op()
            }
        }
    }

    func addOperation(op: (@escaping ()->Void)) {
        self.operations.append { [weak self] () in
            if let sself = self {
                DispatchQueue.global().asyncAfter(deadline: .now() + sself.delay) {
                    print("Delay: " + String(sself.delay))
                    op()
                }
            }
        }
    }
    
    // Passing self as an argument would also be a good approach, but it would
    // require modifying our definition of self.operations so stored closure
    // accept an argument. Ådapting the code and verifying it works as expected
    // is left as an exercise to the reader.
    
//    func addOperationAlsoOK(op: (@escaping ()->Void)) {
//        self.operations.append { (self) in
//            DispatchQueue.global().asyncAfter(deadline: .now() + self.delay) {
//                op()
//            }
//        }
//    }
    
    func runLastOperation(index: Int) {
        self.operations.last!()
    }
    
    deinit {
        self.delay = -1.0
        print("Juggler named " + self.name + " DEINITIED")
    }
}

class ViewController: UIViewController {

    var opJ = OperationJuggler(name: "first")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // If you execute this code, the OperationJuggler will not be released
        // due to a retain cycle. Comment it out and run the program
        // to see the trace in the output console. If you do not comment it out,
        // the deinit code of the OperationJuggler will never be called
        // even after the overwrite self.opJ with a newly allocated OperationJugger
        // shortly below.
        opJ.addOperationAndCreateRetainCycle {
            print("Executing operation 1 -- You will not see ")
        }
        
        // addOperation is the correct way of defining a closure that refers to self
        // This code will not cause any retain cycle. You can comment it out or leave it
        // unchanged.
        opJ.addOperation {
            print("Executing operation 1")
        }
        
        self.opJ.runLastOperation(index: 0)

        //-- this will release the previous OperationJuggler
        self.opJ = OperationJuggler(name: "replacement")
    }
}

// Retain cycles would ensue even using primitive type, like in this case.
// Creating a scenario that allows to check whether the retain cycle is created or not,
// like we did in the code above, is left as an exercise to the reader.
class IncrementJuggler {
    
    private var incrementedValues :  [(Int) -> Int] = []
    var baseValue = 100
    
    func addValue(increment: Int) {
        self.incrementedValues.append { (increment) -> Int in
            return self.baseValue + increment
        }
    }
    
    func runOperation(index: Int) {
        //...
    }
}
