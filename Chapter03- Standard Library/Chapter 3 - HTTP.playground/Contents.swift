//: Playground - noun: a place where people can play

import Foundation
import PlaygroundSupport

let url = URL(string: "https://api.website.com/")!
let task = URLSession.shared.dataTask(with: url) { data, response, error in
    if let error = error { return } // handle the error somehow
    guard let response = response as? HTTPURLResponse,
        let data = data else { return }
    // data: Data is set, and all good
}
task.resume()


func get<T>(url: URL, callback: @escaping (T?, Error?) -> Void) ->
    URLSessionTask where T: Decodable {
        let task = URLSession.shared.dataTask(with: url) { data, response,
            error in
            if let error = error {
                callback(nil, error)
                return                
            }
            // Very simple handling of errors, you may wanna
            // have a more in depth implementation
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
        task.resume()
        return task
}

struct MyResult: Decodable {
    /*
     you can put anything decodable here
     the compiler will generate the decodable implementation
     */
}

func handle(result: MyResult) {
    print(result)
}

func handle(handle: Error) {
    print(handle)
}


_ = get(url: URL(string: "http://example.com")!) { (result: MyResult?,
    error) in
    switch (result, error) {
    case (.some(let result), _):
        handle(result: result)
    case (_, .some(let error)):
        handle(handle: error)
    default: // both are nil :/
        break; }
}

func post<T, U>(url: URL, body: U, callback: @escaping (T?, Error?) ->
    Void) throws
    -> URLSessionTask where T: Decodable, U: Encodable {
        var request = URLRequest(url: url)
        request.httpBody = try JSONEncoder().encode(body)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { data, response,
            error in
            // Exact same code as in the get<T> callback, extracted
            handleResponse(data: data,
                           response: response,
                           error: error,
                           callback: callback)
        }
        task.resume()
        return task
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

PlaygroundPage.current.needsIndefiniteExecution = true
