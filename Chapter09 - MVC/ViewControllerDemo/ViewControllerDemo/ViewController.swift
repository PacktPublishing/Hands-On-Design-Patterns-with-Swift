//
//  ViewController.swift
//  ViewControllerDemo
//
//  Created by Florent Vilmart on 2018-08-08.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")

        let controller = StateController<String>()
        // controller.state = .loading
        present(controller, animated: true, completion: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }


}

class BadViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        print("before")
        self.view = UIView(frame: .zero)
        print("after")
    }

    required init?(coder aDecoder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
    }
}

class OtherBadController: UIViewController {
    init() {
        super.init(nibName: "OtherBadController", bundle: nil)
        print("before")
        let width = UIScreen.main.bounds.width
        self.view.frame = CGRect(x: 0, y: 0, width: width, height: width)
        print("after")
    }

    required init?(coder aDecoder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
    }
}


enum State<T> {
    case unknown
    case loading
    case loaded(T)
    case error(Error)
}

class StateController<T>: UIViewController {
    var state: State<T> = .unknown {
        didSet {
            self.updateState()
        }
    }

    func updateState() {
        switch state {
        case .loading:
            self.view.alpha = 0.0
        case .loaded(_):
            self.view.alpha = 1.0
        default: break;
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
    }
}

// Fixed
//class StateController<T>: UIViewController {
//    var state: State<T> = .unknown {
//        didSet {
//            guard isViewLoaded else { return }
//            self.updateState()
//        }
//    }
//
//    func updateState() {
//        switch state {
//        case .loading:
//            self.view.alpha = 0.0
//        case .loaded(_):
//            self.view.alpha = 1.0
//        default: break;
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        updateState()
//    }
//}

class StringStateController: StateController<String> {}

