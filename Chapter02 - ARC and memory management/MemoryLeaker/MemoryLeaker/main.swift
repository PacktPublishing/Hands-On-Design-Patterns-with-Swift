//
//  main.swift
//  MemoryLeaker
//
//  Created by Giordano Scalzo on 12/12/2018.
//  Copyright © 2018 Giordano Scalzo. All rights reserved.
//

import Foundation

class MemoryLeak {
    var ref: MemoryLeak?
    init(ref: MemoryLeak) {
        self.ref = ref
    }
    init() {
        ref = self
    }
}


class Hello {
    func world() {
        print("Hello, World!")
    }
}
let hello = Hello()
hello.world() // set a breakpoint here

func createLeak() {
    let leak = MemoryLeak()
}
createLeak()
print("set a breakpoint here")
