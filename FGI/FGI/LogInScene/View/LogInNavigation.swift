//
//  LogInNavigation.swift
//  FGI
//
//  Created by user on 27.12.2021.
//

import UIKit

final class LogInNavigation: UIView {
    private weak var controller: LogInVC?
    
    func loadView(controller: LogInVC) {
        self.controller = controller
        self.customizeNavigation()
    }
}

private extension LogInNavigation {
    func customizeNavigation() {
        self.controller?.navigationController?.navigationBar.barTintColor = .white
        self.controller?.navigationController?.navigationBar.shadowImage = UIImage()
    }
}
