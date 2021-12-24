//
//  CompanyRouter.swift
//  CompanyEmployee
//
//  Created by user on 17.12.2021.
//

import UIKit

protocol ICompanyRouter {
    func setRootController(controller: UIViewController)
    func setTargerController(controller: UIViewController)
    func next()
}

final class CompanyRouter {
    private var controller: UIViewController?
    private var targertController: UIViewController?
}

extension CompanyRouter: ICompanyRouter {
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
