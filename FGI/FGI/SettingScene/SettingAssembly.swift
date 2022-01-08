//
//  SettingAssembly.swift
//  FGI
//
//  Created by user on 08.01.2022.
//

import UIKit

final class SettingAssembly {
    static func build() -> UIViewController {
        let router = SettingRouter()
        let presenter = SettingPresenter(router: router)
        let controller = SettingVC(presenter: presenter)
        router.setRootController(controller: controller)
        return controller
    }
}
