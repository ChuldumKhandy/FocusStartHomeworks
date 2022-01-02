//
//  DiagramRouter.swift
//  FGI
//
//  Created by user on 02.01.2022.
//

import UIKit

protocol IDiagramRouter {
    func setRootController(controller: UIViewController)
    func backVC()
}

final class DiagramRouter {
    private var controller: UIViewController?
}

extension DiagramRouter: IDiagramRouter{
    func setRootController(controller: UIViewController) {
        self.controller = controller
    }
    func backVC() {
        self.controller?.navigationController?.popViewController(animated: true)
    }
}
