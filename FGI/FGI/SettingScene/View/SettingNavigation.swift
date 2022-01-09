//
//  SettingNavigation.swift
//  FGI
//
//  Created by user on 08.01.2022.
//

import UIKit

protocol ISettingNavigation: UIView {
    var backMenuVC: (() -> Void)? { get set }
    func loadView(controller: SettingVC)
}

final class SettingNavigation: UIView {
    private weak var controller: SettingVC?
    var backMenuVC: (() -> Void)?
}

extension SettingNavigation: ISettingNavigation {
    func loadView(controller: SettingVC) {
        self.controller = controller
        self.customizeNavigation()
    }
}

private extension SettingNavigation {
    func customizeNavigation() {
        self.controller?.title = "Настройки"
        self.controller?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: FontSize.title.rawValue)]
        let leftBarItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(self.backVC))
        leftBarItem.tintColor = .black
        self.controller?.navigationItem.leftBarButtonItem = leftBarItem
    }
    
    @objc func backVC() {
        self.backMenuVC?()
    }
}

