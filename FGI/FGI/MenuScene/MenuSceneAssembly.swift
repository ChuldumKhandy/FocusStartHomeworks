//
//  MenuSceneAssemblt.swift
//  FGI
//
//  Created by user on 30.12.2021.
//

import UIKit

final class MenuSceneAssembly {
    static func build() -> UIViewController {
        let router = MenuRouter()
        let model = CurrencyModel()
        let presenter = MenuPresenter(currencyModel: model, router: router)
        let controller = MenuVC(presenter: presenter)
        router.setRootController(controller: controller)
        return controller
    }
}
