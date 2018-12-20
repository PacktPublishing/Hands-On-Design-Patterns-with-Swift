//
//  AppDependencies.swift
//  DependencyInjection
//
//  Created by Giordano Scalzo on 13/11/2018.
//  Copyright © 2018 trainline. All rights reserved.
//

import UIKit

class AppDependencies {
    private var basketController: BasketController!
    private var productsController: ProductsController!

    init() {
        configureDependencies()
    }

    func installRootViewControllerIntoWindow(window: UIWindow?) {
        guard let mainViewController = window?.rootViewController as? MainViewController else {
            fatalError("The rootViewController must be a MainViewController")
        }
        mainViewController.basketController = basketController
        mainViewController.productsController = productsController
    }

    private func configureDependencies() {
        let configuration = Configuration.loadFromBundleId()
        let apiService = NetworkApi(with: configuration)
        self.basketController = createBasketController(apiService: apiService, configuration: configuration)
        self.productsController = createProductsController(apiService: apiService)
    }

    private func createBasketController(apiService: NetworkApi, configuration: Configuration) -> BasketController {
        let basketService = RestBasketService(apiService: apiService)
        let basketStore = BasketCoreData(with: configuration)
        return BasketController(service: basketService, store: basketStore)
    }

    private func createProductsController(apiService: NetworkApi) -> ProductsController {
        let productsService = RestProductsService(apiService: apiService)
        return ProductsController(service: productsService)
    }
}

class Configuration {
    static func loadFromBundleId() -> Configuration {
        return Configuration()
    }
}

class NetworkApi {
    init(with conf: Configuration) {}
}

class RestBasketService {
    init(apiService: NetworkApi) {}
}

class BasketCoreData {
    init(with conf: Configuration) {}
}

class BasketController {
    init(service: RestBasketService, store: BasketCoreData) {}
}

protocol ProductsService {}
class RestProductsService: ProductsService {
    init(apiService: NetworkApi) {}
}

class ProductsController {
    init(service: RestProductsService) {}
}

class FeaturedProductsController {
    private let productsService: ProductsService

    init(service: ProductsService) {
        self.productsService = service
    }
}


class TodosService1 {
    let repository: TodosRepository

    init(repository: TodosRepository = SqlLiteTodosRepository()) {
        self.repository = repository
    }
}

protocol TodosRepository {
}

class SqlLiteTodosRepository: TodosRepository {}

class ServiceLocator {
    static var instance = ServiceLocator()
    func register(_ aa: Any, forType: Any) {}
}

//let locator = ServiceLocator.instance
//locator.register( SqlLiteTodosRepository(),
//                  forType: TodosRepository.self)
//
//class TodosService {
//    private let repository: TodosRepository
//
//    init() {
//        let locator = ServiceLocator.instance
//        self.repository = locator.resolve(TodosRepository.self)
//    }
//}
