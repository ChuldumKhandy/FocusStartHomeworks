//
//  MenuRouter.swift
//  FGI
//
//  Created by user on 30.12.2021.
//

import UIKit

protocol IMenuRouter {
    func setRootController(controller: UIViewController)
    func nextVC(controller: UIViewController)
}

final class MenuRouter {
    private var controller: UIViewController?
}

extension MenuRouter: IMenuRouter {
    func setRootController(controller: UIViewController) {
        self.controller = controller
    }
    func nextVC(controller: UIViewController) {
        self.controller?.navigationController?.pushViewController(controller, animated: true)
    }
}
