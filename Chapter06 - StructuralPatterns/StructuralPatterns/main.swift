//
//  main.swift
//  StructuralPatterns
//
//  Created by Florent Vilmart on 2018-06-05.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import Foundation
import AdapterPattern

print("Hello, World!")

let USE_FIREBASE = false
let tracker: Tracking

if USE_FIREBASE {
    tracker = FirebaseTrackingAdapter()
} else  {
//    tracker = MixPanelTrackingAdapter()
     tracker = Mixpanel.mainInstance()
}

Tracker.shared.set(trackingAdapter: tracker)
