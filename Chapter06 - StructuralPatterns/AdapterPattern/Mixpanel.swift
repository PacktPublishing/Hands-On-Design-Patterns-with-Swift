//
//  Mixpanel.swift
//  AdapterPattern
//
//  Created by Giordano Scalzo on 13/12/2018.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import Foundation

class Mixpanel {
    private static let instance = Mixpanel()
    static func mainInstance() -> Mixpanel {
        return instance
    }
    public func track(event: String, properties: [String : String]?) {
    }
}
