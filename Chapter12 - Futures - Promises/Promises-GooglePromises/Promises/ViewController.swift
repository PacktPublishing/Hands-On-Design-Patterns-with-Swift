//
//  ViewController.swift
//  Promises
//
//  Created by sergio on 26/11/2018.
//  Copyright © 2018 Sergio De Simone. All rights reserved.
//

import UIKit
import Promises

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        testGitHubAPI()
    }

    func promisedData(_ url: URL) -> Promise<Data> {
        let urlRequest = URLRequest(url: url)
        let defaultSession = URLSession(configuration: .default)
        return wrap { (handler: @escaping (Data, Error?) -> Void) in
            let task = defaultSession.dataTask(with: urlRequest) { (data,
                response, error) in
                if let data = data {
                    handler(data, error)
                } else {
                    handler(Data(), error)
                }
            }
            task.resume()
        }
    }
    
    func testGitHubAPI () {
        if var urlComponents = URLComponents(string:"https://api.github.com/search/repositories") {
            urlComponents.query = "q=sort=stars;order=desc;per_page=1"
            let p : Promise<Data> = promisedData(urlComponents.url!)
            p.then { data -> Promise<Data> in
                let string = String(data:data,
                                    encoding:String.Encoding.utf8)
                print("Most starred repo: \(string!)")
                urlComponents.query = "q=forks=stars;order=desc;per_page=1"
                return self.promisedData(urlComponents.url!)
                }.then { data -> Promise<Data> in
                    let string = String(data:data,
                                        encoding:String.Encoding.utf8)
                    print("Most forked repo: \(string!)")
                    return Promise(data)
                }.catch { error in
                    print("This was unexpected: \(error)")
            }
        }
    }

}

