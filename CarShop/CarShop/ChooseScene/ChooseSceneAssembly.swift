//
//  AssemblyChooseScene.swift
//  CarShop
//
//  Created by user on 05.12.2021.
//

import UIKit

final class AssemblyChooseScene {
    static func build() -> UIViewController {
        let router = ChooseSceneRouter()        
        let car = CarModel()
        let controller = ChooseSceneVC()
        let presenter = ChooseScenePresenter(router: router, car: car, controller: controller)
        controller.presenter = presenter
        router.setRootController(controller: controller)        
        return controller
    }
}
