//
//  main.swift
//  AbstractFactories
//
//  Created by Florent Vilmart on 18-05-29.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import Foundation
import AppKit
import CoreLocation

print("Hello, World!")

typealias ResultBlock = (Bool, Error?) -> Void
typealias DataResultBlock = (Data?, Error?) -> Void

protocol UserLocationService {
    func getUserLocation(done: (CLLocation) -> Void)
}

struct CommonUserLocationService: UserLocationService {
    func getUserLocation(done: (CLLocation) -> Void) {}
}

protocol PushNotificationService {
    func register(_ done: ResultBlock)
}

struct iOSPushNotificationService: PushNotificationService {
    func register(_ done: ResultBlock) {}
}

struct macOSPushNotificationService: PushNotificationService {
    func register(_ done: ResultBlock) {}
}


protocol ServicesFactoryType {
    func getPushService() -> PushNotificationService
    func getUserLocationService() -> UserLocationService
}

extension ServicesFactoryType {
    func defaultUserLocationService() -> UserLocationService {
        return CommonUserLocationService()
    }
    func getUserLocationService() -> UserLocationService {
        return defaultUserLocationService()
    }
}

struct macOSServicesFactory: ServicesFactoryType {
    func getPushService() -> PushNotificationService {
        if #available(OSX 10.9, *) { // Mavericks only
            return macOSPushNotificationService()
        }
        /* add additional platform support here */
        fatalError("Push notificaitons are not supported on this platform")
    }
}

struct iOSServicesFactory: ServicesFactoryType {
    func getPushService() -> PushNotificationService {
        if #available(iOS 10.0, *) { // New API based on UNNotification
            return iOSPushNotificationService()
        }
        fatalError("Push notificaitons are not supported on this platform")
    }
    func getUserLocationService() -> UserLocationService {
        if true {
            return defaultUserLocationService()
        }
        fatalError("Yolo")
    }
}

struct ServicesFactory {
    static let shared: ServicesFactoryType = {
        if #available(OSX 10.0, *) {
            return macOSServicesFactory()
        } else if #available(iOS 1.0, *) {
            return iOSServicesFactory()
        }
    }()

    internal init() {}

    func getPushService() -> PushNotificationService {
        fatalError("abstract method")
    }

    func getUserLocationService() -> UserLocationService {
        return CommonUserLocationService()
    }
}


let pushService = ServicesFactory.shared.getPushService()
pushService.register { (success, error) in
    // handle success
}
let userService = ServicesFactory.shared.getUserLocationService()


class Earth {

    static let instance = Earth()

    private init() {}

    func spinAroundTheSun() { /* */ }
}


let planetEarth = Earth.instance
planetEarth.spinAroundTheSun()


class CallController: NSViewController {}
class MessageController: NSViewController {}

enum ContactAction {
    case call
    case message
    case poke
}

extension ContactAction {
    var buttonTitle: String {
        switch self {
        case .call:
            return "Call"
        case .message:
            return "Message"
        case .poke:
            return "Poke"
        }
    }

    var localizedButtonTitle: String {
        return NSLocalizedString(buttonTitle, comment: "\(self) button title")
    }
}

class ContactController: NSViewController {

    lazy var callButton = makeButton(for: .call)
    lazy var messageButton = makeButton(for: .message)
    lazy var pokeButton = makeButton(for: .poke)

    open func makeButton(for action: ContactAction) -> NSButton {
        return NSButton(title: action.localizedButtonTitle,
                        target: self,
                        action: #selector(processAction(from:)))
    }

    private func action(for button: NSButton) -> ContactAction {
        switch button {
        case callButton:
            return .call
        case messageButton:
            return .message
        case pokeButton:
            return .poke
        default:
            fatalError("Unknown button")
        }
    }

    @objc
    private func processAction(from button: NSButton) {
        handle(action: action(for: button))
    }

    func controller(for action: ContactAction) -> NSViewController? {
        switch action {
        case .call:
            return CallController()
        case .message:
            return MessageController()
        default:
            return nil
        }
    }

    func handle(action: ContactAction) {
        guard action != .poke else {
            // handle the poke
            return
        }
        guard let controller = controller(for: action) else {
            return
        }
        presentViewControllerAsModalWindow(controller)
    }
}

class MyContactController: ContactController {
    override func makeButton(for action: ContactAction) -> NSButton {
        let button = super.makeButton(for: action)
        button.isEnabled = false
        return button
    }
}

let cc = ContactController()
print(cc.callButton)
