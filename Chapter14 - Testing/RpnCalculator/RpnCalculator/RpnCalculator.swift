//
//  RpnCalculator.swift
//  RpnCalculator
//
//  Created by Giordano Scalzo on 29/10/2018.
//  Copyright © 2018 Giordano Scalzo. All rights reserved.
//

import Foundation

protocol RpnCalculator {
    var line3: String { get }
    var line2: String { get }
    var line1: String { get }
    var line0: String { get }
    
    func new(element: String)
}


struct Stack {
    private var data: [String] = []

    mutating func appendAtTopmost(_ element: String) {
        guard !data.isEmpty else {
            return push(element)
        }
        data[data.count - 1] += element
    }

    mutating func push(_ element: String) {
        data.append(element)
    }
    
    mutating func pop() -> String {
        return data.popLast() ?? ""
    }

    subscript(idx: Int) -> String {
        guard idx < data.count else {
            return ""
        }
        return data[data.count - idx - 1]
    }
}

class FloatRpnCalculator: RpnCalculator {

    var line3: String {
        get {
            return stack[3]
        }
    }
    var line2: String {
        get {
            return stack[2]
        }
    }
    var line1: String {
        get {
            return stack[1]
        }
    }
    var line0: String {
        get {
            return stack[0]
        }
    }
    
    private var stack: Stack = Stack()
    
    func new(element: String) {
        switch element {
        case "e":
            stack.push("")
        case "+":
            return doOperation { $0 + $1 }
        case "*":
            return doOperation { $0 * $1 }
        case "/":
            return doOperation { $0 / $1 }
        case "-":
            return doOperation { $0 - $1 }
        default:
            stack.appendAtTopmost(element)
        }
    }

    private func doOperation(operation: (Float, Float) -> Float) {
        if let secondOperand = Float(stack.pop()),
            let firstOperand = Float(stack.pop()) {
            let result = operation(firstOperand, secondOperand)
            stack.push(String(format: "%.2f", result))
        }
    }
}
