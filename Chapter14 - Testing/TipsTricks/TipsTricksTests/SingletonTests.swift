//
//  SingletonTests.swift
//  TipsTricksTests
//
//  Created by Giordano Scalzo on 06/11/2018.
//  Copyright © 2018 trainline. All rights reserved.
//

import XCTest
@testable import TipsTricks

class SingletonTests: XCTestCase {

    func testFetchingData() {
        class MockNetworkSession: NetworkSession {
            typealias CompletionHandler = NetworkSession.CompletionHandler

            var requestedURL: URL?

            func performRequest(for url: URL, completionHandler: @escaping CompletionHandler) {
                requestedURL = url

                let data = "Hello world".data(using: .utf8)
                completionHandler(data, nil, nil)
            }
        }

        let session = MockNetworkSession()
        let loader = DataFetcher(session: session)

        var result: DataFetcher.Result = .data("".data(using: .utf8)!)
        let url = URL(string: "test/api")!
        loader.fetch(from: url) { result = $0 }

        XCTAssertEqual(session.requestedURL, url)
        switch result {
        case .data(let data):
            XCTAssertEqual(data, "Hello world".data(using: .utf8)!)
        case .error:
            XCTFail()
        }
    }
}

class DataFetcher {
    enum Result {
        case data(Data)
        case error(Error)
    }
    private let session: NetworkSession

    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }

    func fetch(from url: URL, completionHandler: @escaping (Result) -> Void) {
        session.performRequest(for: url) { (data, response, error) in
            if let error = error {
                return completionHandler(.error(error))
            }

            completionHandler(.data(data ?? Data()))
        }
    }
}

protocol NetworkSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    func performRequest(for url: URL, completionHandler: @escaping CompletionHandler)
}

extension URLSession: NetworkSession {
    typealias CompletionHandler = NetworkSession.CompletionHandler

    func performRequest(for url: URL, completionHandler: @escaping CompletionHandler) {
        let task = dataTask(with: url, completionHandler: completionHandler)
        task.resume()
    }
}
