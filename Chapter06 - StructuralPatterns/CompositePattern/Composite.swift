//
//  Composite.swift
//  StructuralPatterns
//
//  Created by Giordano Scalzo on 13/12/2018.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import Foundation

protocol Testable {
    func run() throws
}

typealias TestImplementation = () throws -> Void

class UnitTest: Testable {
    let name: String
    private let block: TestImplementation
    init(name: String, block: @escaping TestImplementation) {
        self.name = name
        self.block = block
    }
    func run() throws {
        try self.block()
        print("UnitTest \(name) ran successfully")
    }
}


class TestSuite: Testable {
    let name: String
    private(set) var testables: [Testable]
    init(name: String, _ testables: [Testable] = []) {
        self.name = name
        self.testables = testables
    }
    func add(_ testable: Testable) {
        testables.append(testable)
    }
    func run() throws {
        print("Suite \(name) started")
        let errors = testables.compactMap { (testable) -> Error? in
            do {
                try testable.run()

            } catch let e {
                return e
            }
            return nil }
        if errors.count > 0 {
            throw Errors(errors: errors)
        }
        print("Suite \(name) ran successfully")
    }
    struct Errors: Error {
        let errors: [Error]
    } }
