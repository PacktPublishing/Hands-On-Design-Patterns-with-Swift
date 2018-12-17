//
//  main.swift
//  MemoryLeaker
//
//  Created by Giordano Scalzo on 12/12/2018.
//  Copyright © 2018 Giordano Scalzo. All rights reserved.
//

import Foundation

class MemoryLeak {
    weak var ref: MemoryLeak?
    init(ref: MemoryLeak) {
        self.ref = ref
    }
    init() {
        ref = self
    } }
func test() -> MemoryLeak {
    let a = MemoryLeak()
    let b = MemoryLeak(ref: a)
    let c = MemoryLeak(ref: b)
    a.ref = c
    return a
}

let result = test()
assert(result.ref != nil)
