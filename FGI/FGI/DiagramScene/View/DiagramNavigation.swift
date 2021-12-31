//
//  DiagramNavigation.swift
//  FGI
//
//  Created by user on 27.12.2021.
//

import UIKit

final class DiagramNavigation: UIView {
    private weak var controller: DiagramVC?
    
    func loadView(controller: DiagramVC) {
        self.controller = controller
        self.customizeNavigation()
    }
}

private extension DiagramNavigation {
    func customizeNavigation() {
        self.controller?.navigationController?.navigationBar.barTintColor = .white
        self.controller?.navigationController?.navigationBar.shadowImage = UIImage()
        self.controller?.title = "Индек страха и жадности"
    }
}
