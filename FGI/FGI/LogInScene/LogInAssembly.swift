//
//  LogInAssembly.swift
//  FGI
//
//  Created by user on 27.12.2021.
//

import UIKit

final class LogInAssembly {
    static func build() -> UIViewController {
        let router = LogInRouter()
        //let model = LogInUser()
        let presenter = LogInPresenter(router: router)
        let controller = LogInVC(presenter: presenter)
        router.setRootController(controller: controller)
        return controller
    }
}
