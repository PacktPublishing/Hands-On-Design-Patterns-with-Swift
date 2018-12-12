//: Playground - noun: a place where people can play

import Foundation
import PlaygroundSupport

struct MyBody: Encodable {
}

struct MyResult: Decodable {
    /*
     you can put anything decodable here
     the compiler will generate the decodable implementation
     */
}

func handleResponse<T>(data: Data?, response: URLResponse?, error: Error?, callback: @escaping (T?, Error?) ->
    Void) where T: Decodable {
    // Exact same code as in the get<T> callback, extracted
    if let error = error {
        callback(nil, error)
        return
    }
    if let data = data {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            callback(result, nil)
        } catch let error {
            callback(nil, error)
        }
    } else {
        callback(nil, nil)
    }
}


extension URLRequest {
    enum HTTPMethod: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    init<T>(url: URL, method: HTTPMethod, body: T?) throws where T:
        Encodable {
            self.init(url: url)
            httpMethod = method.rawValue
            if let body = body  {
                httpBody = try JSONEncoder().encode(body)
            }
    }
}

extension URLSession {
    func dataTask<T>(with request: URLRequest,
                     callback: @escaping (T?, Error?) -> Void)
        throws -> URLSessionTask where T: Decodable {
            return URLSession.shared.dataTask(with: request) { data, response,
                error in
                handleResponse(data: data,
                               response: response,
                               error: error,
                               callback: callback)

            }
    }

}


let request = try! URLRequest(url: URL(string: "http://example.com")!,
                              method: .POST,
                              body: MyBody())

let task = try? URLSession.shared.dataTask(with: request) { (result:
    MyResult?, error) in
    // Handle result / error
}
task?.resume()

PlaygroundPage.current.needsIndefiniteExecution = true
