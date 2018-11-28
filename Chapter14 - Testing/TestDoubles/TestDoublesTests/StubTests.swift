//
//  StubTests.swift
//  TestDoublesTests
//
//  Created by Giordano Scalzo on 03/11/2018.
//  Copyright © 2018 trainline. All rights reserved.
//


import XCTest

class StubTests: XCTestCase {

    func testAddATaskToPreloadedTasks() {
        let taskManager = TaskManagerV3(store: StubTaskStoreWithTwoTasks())
        taskManager.add(task: Task())
        XCTAssertEqual(taskManager.count, 3)
    }

}

class TaskManagerV3 {
    private let store: TaskStoreV3

    init(store: TaskStoreV3) {
        self.store = store
    }
    func add(task: Task) {
        store.add(task: task)
    }
    var count: Int {
        return store.allTasks.count
    }
}

protocol TaskStoreV3 {
    var allTasks: [Task] { get }
    func add(task: Task)
}

class StubTaskStoreWithTwoTasks: TaskStoreV3 {
    private(set) var allTasks = [Task(), Task()]

    func add(task: Task) {
        allTasks.append(task)
    }
}

