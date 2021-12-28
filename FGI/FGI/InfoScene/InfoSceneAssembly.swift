//
//  InfoSceneAssembly.swift
//  FGI
//
//  Created by user on 23.12.2021.
//

import UIKit

final class InfoSceneAssembly {
    static func build() -> UIViewController {
        let router = InfoRouter()
        let presenter = InfoPresenter(router: router)
        let controller = InfoVC(presenter: presenter)
        router.setRootController(controller: controller)
        return controller
    }
}
