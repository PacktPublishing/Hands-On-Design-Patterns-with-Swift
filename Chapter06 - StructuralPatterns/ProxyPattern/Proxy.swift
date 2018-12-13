//
//  Proxy.swift
//  StructuralPatterns
//
//  Created by Giordano Scalzo on 13/12/2018.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import Foundation
class LoggingCachedNetworking: CachedNetworking {
    private func log(request: URLRequest) {
        // TODO: implement proper logging
    }
    private func log(response: URLResponse?,
                     data: Data?,
                     error: Error?,
                     fromCache: Bool,
                     forRequest: URLRequest) {
        // TODO: implement proper logging
    }
    override func run(with request: URLRequest, completionHandler:
        @escaping (Data?, URLResponse?, Error?, Bool) -> Void) {
        self.log(request: request)
        super.run(with: request) { (data, response, error, fromCache) in
            self.log(response: response,
                     data: data,
                     error: error,
                     fromCache: fromCache,
                     forRequest: request)
            completionHandler(data, response, error, fromCache)
        }
    }
}
