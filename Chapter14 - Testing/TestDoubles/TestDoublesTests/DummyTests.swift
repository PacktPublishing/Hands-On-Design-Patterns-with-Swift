//
//  DummyTests.swift
//  TestDoublesTests
//
//  Created by Giordano Scalzo on 03/11/2018.
//  Copyright © 2018 trainline. All rights reserved.
//

import XCTest

class DummyTests: XCTestCase {

    func testDummy() {
        let taskManager = TaskManagerV1(service: TaskManagerServiceDummy())
        taskManager.add(task: Task())
        taskManager.add(task: Task())
        XCTAssertEqual(taskManager.count, 2)
    }

}

struct TaskManagerServiceDummy: TaskManagerServiceV1 {
    func fetchTask(completion: ([Task]) -> Void) {}
    func sync(tasks: [Task]) {}
}

class TaskManagerV1 {
    private var tasks = [Task]()
    private let service: TaskManagerServiceV1

    init(service: TaskManagerServiceV1) {
        self.service = service
    }
    func add(task: Task) {
        tasks.append(task)
    }
    var count: Int {
        return tasks.count
    }
    func sync() {
        service.sync(tasks: tasks)
    }
}

protocol TaskManagerServiceV1 {
    func fetchTask(completion: ([Task]) -> Void)
    func sync(tasks: [Task])
}
