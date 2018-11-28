//
//  BasketViewController.swift
//  DependencyInjection
//
//  Created by Giordano Scalzo on 11/11/2018.
//  Copyright © 2018 trainline. All rights reserved.
//

import UIKit

class BasketViewController: UIViewController {
    private var service: BasketService!
    private var store: BasketStore!

    func set(service: BasketService, store: BasketStore) {
        self.service = service
        self.store = store
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        precondition(service != nil, "BasketService required")
        precondition(store != nil, "BasketStore required")
        // ...
    }
    
}

class CheckoutViewController: UIViewController {
    var time: Time = DefaultTime()
}

protocol Time {
    func now() -> Date
}

struct DefaultTime: Time {
    func now() -> Date {
        return Date()
    }
}
