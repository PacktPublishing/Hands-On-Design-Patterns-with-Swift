//
//  MockTests.swift
//  TestDoublesTests
//
//  Created by Giordano Scalzo on 05/11/2018.
//  Copyright © 2018 trainline. All rights reserved.
//
import XCTest

class MockTests: XCTestCase {

    func testAddAnCountTasks() {
        let firstTaskToBeAdded = Task()
        let secondTaskToBeAdded = Task()
        let mockTaskStore = MockTaskStore()
        mockTaskStore.callAdd(with: firstTaskToBeAdded)
        mockTaskStore.callCount(returning: 1)
        mockTaskStore.callAdd(with: secondTaskToBeAdded)
        mockTaskStore.callCount(returning: 2)

        let taskManager = TaskManager(store: mockTaskStore)
        _ = taskManager.add(task: firstTaskToBeAdded)
        _ = taskManager.add(task: secondTaskToBeAdded)

        mockTaskStore.verify()
    }

}

struct Task: Equatable {
    let id = UUID().uuidString
}

class TaskManager {
    private let store: TaskStore

    init(store: TaskStore) {
        self.store = store
    }
    func add(task: Task) -> Int {
        store.add(task: task)
        return store.count
    }
    var count: Int {
        return store.count
    }
}

protocol TaskStore {
    func add(task: Task)
    var count: Int { get }
}

class MockTaskStore: TaskStore {
    private enum FunctionType {
        case add, count
    }

    private struct FunctionInvocation {
        let type: FunctionType
        let params: [Any]
    }

    private var expected = [FunctionInvocation]()
    private var actual = [FunctionInvocation]()
    private var nextCall: Int = 0

    var count: Int {
        let currentCall = expected[nextCall]
        let returningValue = (currentCall.params[0] as? Int) ?? 0
        actual.append(FunctionInvocation(type: .count, params: [returningValue]))

        nextCall = expected.index(after: nextCall)
        return returningValue
    }

    func add(task: Task) {
        actual.append(FunctionInvocation(type: .add, params: [task]))
        nextCall = expected.index(after: nextCall)
    }

    func callAdd(with task: Task) {
        expected.append(FunctionInvocation(type: .add, params: [task]))
        nextCall = expected.startIndex
    }

    func callCount(returning value: Int) {
        expected.append(FunctionInvocation(type: .count, params: [value]))
        nextCall = expected.startIndex
    }

    func verify() {
        XCTAssertEqual(expected.count, actual.count)
        zip(expected, actual).forEach { (expected, actual) in
            XCTAssertEqual(expected.type, actual.type)
            switch (expected.type, actual.type) {
            case (.add, .add):
                if let expectedParam = expected.params.first as? Task,
                    let actualParam = actual.params.first as? Task {
                        XCTAssertEqual(expectedParam, actualParam)
                } else {
                    XCTFail("Wrong parameter for call of type \(expected.type)")
                }
            default:
                break
            }
        }
    }
}

