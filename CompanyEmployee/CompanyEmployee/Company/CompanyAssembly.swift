//
//  CompanyAssembly.swift
//  CompanyEmployee
//
//  Created by user on 15.12.2021.
//

import UIKit

final class CompanyAssembly {
    static func build() -> UIViewController {
        let router = CompanyRouter()
        let presenter = CompanyPresenter(router: router)
        let controller = CompanyVC(presenter: presenter)
        router.setRootController(controller: controller)
        return controller
    }
}
