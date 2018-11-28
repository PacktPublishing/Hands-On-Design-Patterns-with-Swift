//
//  RpnCalculatorTests.swift
//  RpnCalculatorTests
//
//  Created by Giordano Scalzo on 29/10/2018.
//  Copyright © 2018 Giordano Scalzo. All rights reserved.
//

import XCTest
@testable import RpnCalculator

protocol CalculatorAsserting {
    var rpnCalculator: RpnCalculator { get }
}

extension CalculatorAsserting {
    // https://www.bignerdranch.com/blog/creating-a-custom-xctest-assertion/
    func assertThatEntering(elements: [String],
                            resultShouldBeEqualTo result: String,
                            file: StaticString = #file,
                            line: UInt = #line) {
        elements.forEach {
            rpnCalculator.new(element: $0)
        }
        XCTAssertEqual(rpnCalculator.line0, result, file: file, line: line)
    }
}

class RpnCalculator_TapOne: XCTestCase, CalculatorAsserting {
    var rpnCalculator: RpnCalculator = FloatRpnCalculator()
    override func setUp() {
        super.setUp()
        rpnCalculator.new(element: "1")
    }

    func test__OneOnTopMostPlace() {
        XCTAssertEqual(rpnCalculator.line0, "1")
    }
    
    func test__AndEnter__OneOnSecondPlace() {
        rpnCalculator.new(element: "e")
        XCTAssertEqual(rpnCalculator.line0, "")
        XCTAssertEqual(rpnCalculator.line1, "1")
    }
    
    func test__EnterTwoAdd__ThreeOnFirstPlace() {
        rpnCalculator.new(element: "e")
        rpnCalculator.new(element: "2")
        rpnCalculator.new(element: "+")
        XCTAssertEqual(rpnCalculator.line0, "3.00")
    }
    
    func test__EnterTwoEnterThreeAddMultiply__NineOnFirstPlace() {
        assertThatEntering(elements: ["e", "2", "+", "e", "3", "*"], resultShouldBeEqualTo: "9.00")
    }

}

class RpnCalculator_Operations: XCTestCase, CalculatorAsserting {
    var rpnCalculator: RpnCalculator = FloatRpnCalculator()

    func test__SixEnterTwoDivision__ThreeOnFirstPlace() {
        assertThatEntering(elements: ["6", "e", "2", "/"], resultShouldBeEqualTo: "3.00")
    }

    func test__SixEnterTwoSubctract__FourOnFirstPlace() {
        assertThatEntering(elements: ["6", "e", "2", "-"], resultShouldBeEqualTo: "4.00")
    }
}

class RpnCalculator_Decimal: XCTestCase, CalculatorAsserting {
    var rpnCalculator: RpnCalculator = FloatRpnCalculator()

    func test__SixPointThreeEnterFourAdd__TenPointThreeOnFirstPlace() {
        assertThatEntering(elements: ["6", ".", "3", "e", "4", "+"], resultShouldBeEqualTo: "10.30")
    }
}

class RpnCalculator_LongOperation: XCTestCase, CalculatorAsserting {
    var rpnCalculator: RpnCalculator = FloatRpnCalculator()

    func test__SixPointThreeEnterFourAdd__TenPointThreeOnFirstPlace() {
        assertThatEntering(elements: ["6", ".", "3", "e", "4", "+"], resultShouldBeEqualTo: "10.30")
    }

    func t1est__LongOperation__Work() {
        assertThatEntering(elements: ["1", "5", "e",
                                    "7", "e",
                                    "1", "e",
                                    "1", "e",
                                    "+",
                                    "−",
                                    "/",
                                    "3",
                                    "*",
                                    "2", "e",
                                    "1", "e",
                                    "1",
                                    "+",
                                    "+",
                                    "−"], resultShouldBeEqualTo: "5.00")
    }

}

