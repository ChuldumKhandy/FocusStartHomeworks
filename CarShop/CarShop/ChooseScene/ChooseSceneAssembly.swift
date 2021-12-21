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
        let presenter = ChooseScenePresenter(router: router, car: car)
        let controller = ChooseSceneVC(presenter: presenter)
        router.setRootController(controller: controller)        
        return controller
    }
}
