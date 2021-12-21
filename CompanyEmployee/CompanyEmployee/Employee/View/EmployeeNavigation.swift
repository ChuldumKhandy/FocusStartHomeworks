//
//  EmployeeNavigation.swift
//  CompanyEmployee
//
//  Created by user on 16.12.2021.
//

import UIKit

protocol IEmployeeNavigation: UIView {
    var addHandler: (() -> Void)? { get set }
    func loadView(controller: EmployeeVC)
}

final class EmployeeNavigation: UIView {
    private weak var controller: EmployeeVC?
    private let addButton = UIButton()
    var addHandler: (() -> Void)?
}

extension EmployeeNavigation: IEmployeeNavigation {
    func loadView(controller: EmployeeVC) {
        self.controller = controller
        self.customizeButton()
        self.customizeNav()
    }
}

private extension EmployeeNavigation {
    func customizeNav() {
        self.controller?.title = "Сотрудники"
        self.controller?.navigationItem.setRightBarButton(UIBarButtonItem(customView: self.addButton), animated: false)
    }
    
    func customizeButton() {
        self.addButton.contentMode = .left
        self.addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        self.addButton.addTarget(self, action: #selector(self.touchedDown), for: .touchDown)
    }
    
    @objc private func touchedDown() {
        self.addHandler?()
    }
}
