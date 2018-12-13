//
//  Facade.swift
//  StructuralPatterns
//
//  Created by Giordano Scalzo on 13/12/2018.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import Foundation

class Cache {
    func set(response: URLResponse, data: Data, for request: URLRequest) {
        // TODO: Implement me
    }
    func get(for request: URLRequest) -> (URLResponse, Data)? {
        // TODO: Implement me
        return nil
    }
    func remove(for request: URLRequest) {
        // TODO: Implement me
    }
    func allData() -> [URLRequest: (URLResponse, Data)] {
        return [:]
    }
}

class CacheCleaner {
    let cache: Cache
    var isRunning: Bool {
        return timer != nil
    }
    private var timer: Timer?
    init(cache: Cache) {
        self.cache = cache
    }
    func startIfNeeded() {
        if isRunning { return }
        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true)
        { [unowned self] (timer) in
            let cacheData = self.cache.allData()
            // TODO: inspect cache data, and remove cached elemtns that are too old }
        }
    }
    func stop() {
        timer?.invalidate()
        timer = nil
    }
}


class CachedNetworking {
    let session: URLSession
    private let cache = Cache()
    private lazy var cleaner = CacheCleaner(cache: cache)
    init(configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }
    init(session: URLSession) {
        self.session = session
    }
    init() {
        self.session = URLSession.shared
    }

    func run(with request: URLRequest, completionHandler: @escaping (Data?,
        URLResponse?, Error?, Bool) -> Void) {
        if let (response, data) = cache.get(for: request) {
            completionHandler(data, response, nil, true)
            return
        }
        cleaner.startIfNeeded()
        session.dataTask(with: request) { [weak self] (data, response,
            error) in
            if let data = data,
                let response = response {
                
                self?.cache.set(response: response, data: data, for: request)
            }

            completionHandler(data, response, error, false)
            }.resume()
    }
    deinit {
        cleaner.stop()
    }
}
