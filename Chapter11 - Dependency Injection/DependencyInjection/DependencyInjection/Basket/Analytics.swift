//
//  Analytics.swift
//  DependencyInjection
//
//  Created by Giordano Scalzo on 11/11/2018.
//  Copyright © 2018 trainline. All rights reserved.
//

import Foundation

class Analytics {
    static private(set) var instance: Analytics = NoAnalytics()
    static func setAnaylics(analitics: Analytics) {
        self.instance = analitics
    }
    func track(event: Event) {
        fatalError("Implement in a subclass")
    }
}

class NoAnalytics: Analytics {
    override func track(event: Event) {}
}

class GoogleAnalytics: Analytics {
    override func track(event: Event) {
        //...
    }
}

class AdobeAnalytics: Analytics {
    override func track(event: Event) {
        //...
    }
}

struct Event {
    //...
}
