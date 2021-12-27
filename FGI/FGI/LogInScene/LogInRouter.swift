//
//  LogInRouter.swift
//  FGI
//
//  Created by user on 27.12.2021.
//

import UIKit

final class LogInRouter {
    private var controller: UIViewController?

    func setRootController(controller: UIViewController) {
        self.controller = controller
    }
    func next(controller: UIViewController) {
        self.controller?.navigationController?.pushViewController(controller, animated: true)
    }
}
