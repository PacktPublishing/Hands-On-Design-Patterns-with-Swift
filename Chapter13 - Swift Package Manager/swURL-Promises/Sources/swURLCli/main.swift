import Foundation
import swURL

struct Todo: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

func doTask(completion: @escaping (_ data: Todo?, _ error: Error?) -> Void) {

    let group = DispatchGroup()
    group.enter()

    swURL.get(url: URL(string: "https://jsonplaceholder.typicode.com/todos/1")!,
                       completion: { (result : Todo?, error: Error?) in
                           completion(result, error)
                           group.leave()
                       })

    group.wait()
}

doTask { (result : Todo?, error: Error?) -> Void in 
    print("Hello, world!")
}

