//
//  Factories.swift
//  FactoryMethods
//
//  Created by Florent Vilmart on 18-05-31.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {

    convenience init(forError error: Error, onOK handler: @escaping (UIAlertAction) -> Void) {
        let title = NSLocalizedString("There was an error", comment: "Error alert title")
        let message = error.localizedDescription
        let OK = NSLocalizedString("OK", comment: "Error alert OK button title")
        self.init(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: OK, style: .cancel, handler: handler)
        addAction(okAction)
    }

    static func forError(_ error: Error, onOK handler: @escaping (UIAlertAction) -> Void) -> UIAlertController {
        let title = NSLocalizedString("There was an error", comment: "Error alert title")
        let message = error.localizedDescription
        let OK = NSLocalizedString("OK", comment: "Error alert OK button title")
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: OK, style: .cancel, handler: handler)
        controller.addAction(okAction)
        return controller
    }

    func tryMe() {
        struct MyError: Error {}

        do {
            throw MyError()
        } catch let e {
            UIAlertController(forError: e) { (action) in

            }
            present(UIAlertController.forError(e) { (action) in

            }, animated: true, completion: nil)
        }
    }

}


class UIAlertControllerFactory {
    static let shared = UIAlertControllerFactory()
    private init() {}

    func alertControllerFor( error: Error, onOK handler: @escaping (UIAlertAction) -> Void) -> UIAlertController {
        /* implementation goes here */
        fatalError()
    }
}
