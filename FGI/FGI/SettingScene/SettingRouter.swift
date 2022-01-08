//
//  SettingRouter.swift
//  FGI
//
//  Created by user on 08.01.2022.
//

import UIKit

protocol ISettingRouter {
    func setRootController(controller: UIViewController)
    func next(controller: UIViewController)
}

final class SettingRouter {
    private var controller: UIViewController?
}

extension SettingRouter: ISettingRouter {
    func setRootController(controller: UIViewController) {
        self.controller = controller
    }
    func next(controller: UIViewController) {
        self.controller?.navigationController?.pushViewController(controller, animated: true)
    }
}
