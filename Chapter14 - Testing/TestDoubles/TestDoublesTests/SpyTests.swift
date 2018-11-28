//
//  SpyTests.swift
//  TestDoublesTests
//
//  Created by Giordano Scalzo on 03/11/2018.
//  Copyright © 2018 trainline. All rights reserved.
//

import XCTest

class SpyTests: XCTestCase {

    func testTasksAreFetchedInStartup() {
        let service = SpyTaskManagerService()
        _ = TaskManagerV4(service: service)
        XCTAssertTrue(service.fetchHasBeenCalled)
    }

}

protocol TaskManagerService {
    func fetchTask(completion: ([Task]) -> Void)
    func sync(tasks: [Task])
}

class TaskManagerV4 {
    private let service: TaskManagerService
    private var tasks = [Task]()

    init(service: TaskManagerService) {
        self.service = service
        self.service.fetchTask { [weak self] tasks in
            self?.tasks = tasks
        }
    }
}



class SpyTaskManagerService: TaskManagerService {
    private(set) var fetchHasBeenCalled = false

    func fetchTask(completion: ([Task]) -> Void) {
        fetchHasBeenCalled = true
    }

    func sync(tasks: [Task]) { }
}

