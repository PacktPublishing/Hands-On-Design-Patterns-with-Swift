//
//  ViewController.swift
//  Promises
//
//  Created by sergio on 26/11/2018.
//  Copyright © 2018 Sergio De Simone. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        testReactive()
        testReactiveSchedulers()
    }

    func testReactive() {
        
        let aDisposableBag = DisposeBag()
        let thisIsAnObservableStream = Observable.from([1, 2, 3, 4, 5, 6])
        
        let subscription = thisIsAnObservableStream.subscribe(
            onNext: { print("Next value: \($0)") },
            onError: { print("Error: \($0)") },
            onCompleted: { print("Completed") })
        
        // add the subscription to the disposable bag
        // when the bag is collected, the subscription is disposed
        subscription.disposed(by: aDisposableBag)
        // if you do not use a disposable bag, do not forget this!
        // subscription.dispose()
    }
    
    func testReactiveSchedulers() {

        let aDisposableBag = DisposeBag()
        let thisIsAnObservableStream = Observable.from([1, 2, 3, 4, 5, 6])
            .observeOn(MainScheduler.instance).map { n in
                print("This is performed on the main scheduler")
        }
        
        let subscription = thisIsAnObservableStream
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: { event in
                print("Handle \(event) on main thread? \(Thread.isMainThread)")
            }, onError: { print("Error: \($0). On main thread? \(Thread.isMainThread)")
            }, onCompleted: { print("Completed. On main thread? \(Thread.isMainThread)") })
        
        subscription.disposed(by: aDisposableBag)
    }

}

