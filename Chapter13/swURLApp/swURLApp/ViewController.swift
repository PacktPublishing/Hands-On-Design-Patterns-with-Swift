//
//  ViewController.swift
//  swURLApp
//
//  Created by sergio on 24/11/2018.
//  Copyright © 2018 Sergio De Simone. All rights reserved.
//

import UIKit
import swURL

struct Todo: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}


class ViewController: UIViewController {
    
    func doTask(completion: @escaping (_ data: Todo?, _ error: Error?) -> Void) {
        
        swURL.get(url: URL(string: "https://jsonplaceholder.typicode.com/todos/1")!,
                  completion: { (result : Todo?, error: Error?) in
                    completion(result, error)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        doTask { (result : Todo?, error: Error?) -> Void in
            print("Hello, world!")
        }
        
    }
    
    
}

