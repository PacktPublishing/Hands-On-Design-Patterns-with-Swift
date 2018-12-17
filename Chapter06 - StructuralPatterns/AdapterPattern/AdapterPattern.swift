//
//  File.swift
//  AdapterPattern
//
//  Created by Florent Vilmart on 2018-06-05.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import Foundation

public protocol Tracking {
    func record(event: String)
    func record(event: String, properties: [String: String]?)
}

extension Tracking {
    public func record(event: String) {
        record(event: event, properties: nil)
    }
}

public class MixPanelTrackingAdapter: Tracking {
    private let mixpanel = Mixpanel.mainInstance()
    public init() {}

    public func record(event: String, properties: [String : String]?) {
        mixpanel.track(event: event, properties: properties)
    }
}

extension MixpanelInstance: Tracking {
    public func record(event: String, properties: [String : String]?) {
        track(event: event, properties: properties)
    }
}

public class FirebaseTrackingAdapter: Tracking {
    public init() {}

    public func record(event: String, properties: [String : String]?) {
        Analytics.logEvent(event, parameters: properties)
    }
}

public class Tracker: Tracking {
    public static let shared = Tracker()
    public func set(trackingAdapter: Tracking) {
        self.trackingAdapter = trackingAdapter
        self.trackingAdapter = Mixpanel.mainInstance()
    }
    private var trackingAdapter: Tracking!

    public func record(event: String, properties: [String : String]?) {
        trackingAdapter.record(event: event, properties: properties)
    }
}

