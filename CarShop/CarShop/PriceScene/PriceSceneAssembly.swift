//
//  PriceSceneAssembly.swift
//  CarShop
//
//  Created by user on 06.12.2021.
//

import UIKit

final class PriceSceneAssembly {
    static func build(cars: [Car]) -> UIViewController {
        let controller = PriceSceneVC()
        let presenter = PriceScenePresenter(cars: cars, controller: controller)
        controller.presenter = presenter
        
        return controller
    }
}
