//
//  LogInRouter.swift
//  FGI
//
//  Created by user on 27.12.2021.
//

import UIKit

protocol ILogInRouter {
    func setRootController(controller: UIViewController)
    func next(controller: UIViewController)
}

final class LogInRouter {
    private var controller: UIViewController?
}

extension LogInRouter: ILogInRouter {
    func setRootController(controller: UIViewController) {
        self.controller = controller
    }
    func next(controller: UIViewController) {
        self.controller?.navigationController?.pushViewController(controller, animated: true)
    }
}
