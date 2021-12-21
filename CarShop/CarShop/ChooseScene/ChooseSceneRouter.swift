//
//  Router.swift
//  CarShop
//
//  Created by user on 05.12.2021.
//

import UIKit

final class ChooseSceneRouter {
    private var controller: UIViewController?
    private var targertController: UIViewController?

    func setRootController(controller: UIViewController) {
        self.controller = controller
    }

    func setTargerController(controller: UIViewController) {
        self.targertController = controller
    }

    func next() {
        guard let targertController = self.targertController else {
            return
        }
        self.controller?.navigationController?.pushViewController(targertController, animated: true)
    }
}
