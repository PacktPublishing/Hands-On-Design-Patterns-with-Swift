//
//  ViewController.swift
//  FuturesAndPromisesApp
//
//  Copyright © 2018 Sergio De Simone. All rights reserved.
//

import UIKit
import FuturesAndPromises

struct Todo: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

enum AppError: Error {
    case jsonDecodeError
    case otherError
}

class ViewController: UIViewController {

    private func getDataPromise<T: Decodable>() -> Promise<T> {
        
        let url : String = "https://jsonplaceholder.typicode.com/todos/1"
        let request: URLRequest = URLRequest(url: NSURL(string: url)! as URL)
        let session = URLSession.shared
        
        let promise = Promise<T>()
        
        let task = session.dataTask(with: request as URLRequest,
                                    completionHandler: { data, response, error -> Void in
                                        if (error != nil) {
                                            promise.reject(error!)
                                        } else{
                                            do {
                                                let decoder = JSONDecoder()
                                                let result = try decoder.decode(T.self, from: data!)
                                                promise.resolve(result)
                                            } catch {
                                                promise.reject(AppError.jsonDecodeError)
                                            }
                                        }
        })
        task.resume()
        
        return promise
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getDataPromise().then { (result : Result<Todo>) in
            print("Result: \(result)")
        }
    }


}

