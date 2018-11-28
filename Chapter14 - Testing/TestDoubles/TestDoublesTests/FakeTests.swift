//
//  DummyTests.swift
//  TestDoublesTests
//
//  Created by Giordano Scalzo on 03/11/2018.
//  Copyright © 2018 trainline. All rights reserved.
//

import XCTest

class FakeTests: XCTestCase {

    func testNumberOfTasks() {
        let taskManager = TaskManagerV2(store: FakeTaskStore())
        taskManager.add(task: Task())
        taskManager.add(task: Task())
        XCTAssertEqual(taskManager.count, 2)
    }

}

class TaskManagerV2 {
    private let store: TaskStoreV2

    init(store: TaskStoreV2) {
        self.store = store
    }
    func add(task: Task) {
        store.add(task: task)
    }
    var count: Int {
        return store.allTasks.count
    }
}

protocol TaskStoreV2 {
    var allTasks: [Task] { get }
    func add(task: Task)
}

class FakeTaskStore: TaskStoreV2 {
    private(set) var allTasks = [Task]()

    func add(task: Task) {
        allTasks.append(task)
    }
}
