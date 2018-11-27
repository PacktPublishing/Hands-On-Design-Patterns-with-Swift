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

let mpTracker = MixPanelTrackingAdapter()
let firebaseTracker = AnalyticsTrackingAdapter()

Tracker.shared.set(trackingAdapter: mpTracker)
