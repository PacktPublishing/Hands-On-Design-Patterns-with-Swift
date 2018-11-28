//
//  Basket.swift
//  DependencyInjection
//
//  Created by Giordano Scalzo on 11/11/2018.
//  Copyright © 2018 trainline. All rights reserved.
//

import Foundation

class BasketClient {

    func add(product: Product, to store: BasketStore) {
        store.add(product: product)
        calculateAppliedDiscount()
        //...
    }
    // ...
    private func calculateAppliedDiscount() {
        // ...
    }
}


protocol BasketStore {
    func loadAllProduct() -> [Product]
    func add(product: Product)
    func delete(product: Product)
}

protocol BasketService {
    func fetchAllProduct(onSuccess: ([Product]) -> Void)
    func append(product: Product)
    func remove(product: Product)
}

struct Product {
    let id: String
    let name: String
    //...
}
