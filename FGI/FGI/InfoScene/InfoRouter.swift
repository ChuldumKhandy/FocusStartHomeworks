//
//  InfoRouter.swift
//  FGI
//
//  Created by user on 28.12.2021.
//

import UIKit

protocol IInfoRouter {
    func setRootController(controller: UIViewController)
    func backVC()
}

final class InfoRouter {
    private var controller: UIViewController?
}

extension InfoRouter: IInfoRouter {
    func setRootController(controller: UIViewController) {
        self.controller = controller
    }
    func backVC() {
        self.controller?.navigationController?.popViewController(animated: true)
    }
}
