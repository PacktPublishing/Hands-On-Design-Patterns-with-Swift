import Foundation
import XCTest
@testable import swURL

struct Todo: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

final class swURLTests: XCTestCase {

    func testGet() {

        var todo : Todo = Todo(userId:0, id: 0, title:"", completed:false) 
        let expectation = self.expectation(description: "URLTest")

        swURL.get(url: URL(string: "https://jsonplaceholder.typicode.com/todos/1")!) { 
        (result : Todo?, error: Error?) -> Void in 
             print("RESULT: \(result!)")
            todo = result!
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(todo.id, 1)
    }
    
    static var allTests = [
        ("testGet", testGet),
    ]

}
