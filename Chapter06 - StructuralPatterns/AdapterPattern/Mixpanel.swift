//
//  Mixpanel.swift
//  AdapterPattern
//
//  Created by Giordano Scalzo on 13/12/2018.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import Foundation

//// Mixpanel Mock
public class Mixpanel {
    private static let instance = MixpanelInstance()
    public static func mainInstance() -> MixpanelInstance {
        return instance
    }
}
public class MixpanelInstance {
    public func track(event: String, properties: [String : String]?) {
    }
}
