//
//  RpnCalculatorUITests.swift
//  RpnCalculatorUITests
//
//  Created by Giordano Scalzo on 29/10/2018.
//  Copyright © 2018 Giordano Scalzo. All rights reserved.
//

import XCTest

class RpnCalculatorUITests: XCTestCase {
    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testAddition() {
        let calculator = CalculatorScreen()
        calculator.tapOnTwo()
        calculator.tapOnEnter()
        calculator.tapOnThree()
        calculator.tapOnAdd()

        XCTAssertEqual(calculator.valueOnTopMostPlaceOfTheStack, "5.00")
    }
}

class CalculatorScreen {
    private let app = XCUIApplication()
    //...
    func tapOnTwo() {
        tapOnButton(title: "2")
    }
    func tapOnThree() {
        tapOnButton(title: "3")
    }
    //...
    func tapOnAdd() {
        tapOnButton(title: "+")
    }
    func tapOnEnter() {
        tapOnButton(title: "e")
    }
    //...
    var valueOnTopMostPlaceOfTheStack: String {
        guard let value =
            app.textFields["ui.textfield.line0"].value as? String
            else {
                return ""
        }
        return value
    }

    private func tapOnButton(title: String) {
        app.buttons[title].tap()
    }
}
