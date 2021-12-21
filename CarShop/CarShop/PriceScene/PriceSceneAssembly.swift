//
//  PriceSceneAssembly.swift
//  CarShop
//
//  Created by user on 06.12.2021.
//

import UIKit

final class PriceSceneAssembly {
    static func build(cars: [Car]) -> UIViewController {
        let presenter = PriceScenePresenter(cars: cars)
        let controller = PriceSceneVC(presenter: presenter)
        
        return controller
    }
}
