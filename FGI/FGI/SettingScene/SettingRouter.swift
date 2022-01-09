//
//  SettingRouter.swift
//  FGI
//
//  Created by user on 08.01.2022.
//

import UIKit

protocol ISettingRouter {
    func setRootController(controller: UIViewController)
    func backVC()
}

final class SettingRouter {
    private var controller: UIViewController?
}

extension SettingRouter: ISettingRouter {
    func setRootController(controller: UIViewController) {
        self.controller = controller
    }
    func backVC() {
        self.controller?.navigationController?.popViewController(animated: true)
    }
}
