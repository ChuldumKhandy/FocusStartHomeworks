//
//  AssemblyChooseScene.swift
//  CarShop
//
//  Created by user on 05.12.2021.
//

import Foundation
import UIKit

final class AssemblyChooseScene {
    static func build() -> UIViewController {
        let car = CarModel()
        let controller = ChooseSceneVC()
        let presenter = ChooseScenePresenter(car: car, controller: controller)
        controller.presenter = presenter
        
        return controller
    }
}
