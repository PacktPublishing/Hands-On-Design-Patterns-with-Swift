//
//  MessagingTests.swift
//  RpnCalculatorTests
//
//  Created by Giordano Scalzo on 27/11/2018.
//  Copyright © 2018 Giordano Scalzo. All rights reserved.
//

import Foundation
import XCTest

class MessagingTests: XCTestCase {
    func sum(_ a: Float, _ b: Float) -> Float {
        return a*b
    }

    func testSum() {
        XCTAssertEqual(sum(2, 3), 5, "2 + 3 must be equal to 5")
    }
}
