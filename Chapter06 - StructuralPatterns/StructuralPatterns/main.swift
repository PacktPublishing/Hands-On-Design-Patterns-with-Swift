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


let testSuite = TestSuite(name: "Top Level Suite")
testSuite.add(UnitTest(name: "First Test") {})
testSuite.add(UnitTest(name: "Second Test") {})
testSuite.add(
    TestSuite(name: "ChildSuite", [
        UnitTest(name: "Child 1") {},
        UnitTest(name: "Child 2") {}
        ]) )
try? testSuite.run()


let items = ["kale", "carrots", "salad", "carrots", "cucumber", "celery",
               "pepper", "bell peppers", "carrots", "salad"]
items.count // 10

var shopping = ShoppingList()
items.forEach {
    shopping.add(item: $0)
}
print(shopping)
