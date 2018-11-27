//
//  ViewController.swift
//  Promises
//
//  Created by sergio on 26/11/2018.
//  Copyright © 2018 Sergio De Simone. All rights reserved.
//

import UIKit
import PromiseKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        testGitHubAPI()
    }

    func testGitHubAPI() {
        if var urlComponents = URLComponents(string: "https://api.github.com/search/repositories") {
            urlComponents.query = "q=sort=stars;order=desc;per_page=1"
            let url = urlComponents.url!
            
            URLSession.shared.dataTask(.promise, with: url)
                .then { data -> Promise<(data: Data, response: URLResponse)> in
                    let string = String(data:data.data, encoding:String.Encoding.utf8)
                    print("Most starred repo: \(string!)")
                    urlComponents.query = "q=forks=stars;order=desc;per_page=1"
                    return URLSession.shared.dataTask(.promise, with: urlComponents.url!)
                }
                .then { data -> Promise<Data> in
                    let string = String(data:data.data, encoding:String.Encoding.utf8)
                    print("Most forked repo: \(string!)")
                    return Promise<Data> { seal in seal.fulfill(data.data)}
                }
                .catch { error in
                    print("This was unexpected: \(error)")
            }
        }
    }

}

