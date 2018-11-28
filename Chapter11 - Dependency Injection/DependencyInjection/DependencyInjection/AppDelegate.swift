//
//  AppDelegate.swift
//  DependencyInjection
//
//  Created by Giordano Scalzo on 11/11/2018.
//  Copyright © 2018 trainline. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let dependencies = AppDependencies()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        dependencies.installRootViewControllerIntoWindow(window: window)
        return true
    }
}
