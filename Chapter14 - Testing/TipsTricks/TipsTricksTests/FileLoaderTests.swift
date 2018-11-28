//
//  FileLoaderTests.swift
//  TipsTricksTests
//
//  Created by Giordano Scalzo on 07/11/2018.
//  Copyright © 2018 trainline. All rights reserved.
//

import XCTest

class FileLoaderTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testLoadingFile() {
        let fileLoader = FileLoader()

        fileLoader.loadContent(fromFilename: "FixturePlayers") { result in
            guard let array = result as? [[String: Any]] else {
                return XCTFail()
            }
            XCTAssertEqual(5, array.count)
        }
    }

    func testLoadingFile1() {
        let fileLoader = FileLoader()

        let expectation = self.expectation(description: "Loading")

        fileLoader.loadContent(fromFilename: "FixturePlayers") { result in
            defer {
                expectation.fulfill()
            }
            guard let array = result as? [[String: Any]] else {
                return XCTFail()
            }
            XCTAssertEqual(5, array.count)
        }

        waitForExpectations(timeout: 5)
    }
}


class FileLoader {
    func loadContent(fromFilename: String,
                     onSuccess: @escaping (Any) -> Void) {
        guard let path = Bundle.main.path(forResource: fromFilename, ofType: "json") else {
            return
        }

        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped) else {
                print("Error: Couldn't decode data")
                return

            }

            guard let decodedJSON = try? JSONSerialization.jsonObject(
                with: data, options: []) else {
                    print("Error: Couldn't decode data")
                    return
            }
            DispatchQueue.main.async {
                onSuccess(decodedJSON)
            }
        }
    }
}
