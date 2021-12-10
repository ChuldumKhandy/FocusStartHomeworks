//
//  PriceSceneAssembly.swift
//  CarShop
//
//  Created by user on 06.12.2021.
//

import UIKit

final class PriceSceneAssembly {
    static func build(car: Car) -> UIViewController {
//        let router = PriceSceneRouter()
        let car = Price(car: car)
        let controller = PriceSceneVC()
//        let presenter = PriceScenePresenter(router: router, car: car, controller: controller)
//        controller.presenter = presenter
//        router.setRootController(controller: controller)
//        router.setTargerController(controller: PriceSceneAssembly.build())
        
        return controller
    }
}
