//
//  CompanyNavigation.swift
//  CompanyEmployee
//
//  Created by user on 15.12.2021.
//

import UIKit

protocol ICompanyNavigation: UIView {
    var addHandler: (() -> Void)? { get set }
    func loadView(controller: CompanyVC)
}

final class CompanyNavigation: UIView {
    private weak var controller: CompanyVC?
    private let addButton = UIButton()
    var addHandler: (() -> Void)?
}

extension CompanyNavigation: ICompanyNavigation {
    func loadView(controller: CompanyVC) {
        self.controller = controller
        self.customizeButton()
        self.customizeNav()
    }
}

private extension CompanyNavigation {
    func customizeNav() {
        self.controller?.title = "Компании"
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
