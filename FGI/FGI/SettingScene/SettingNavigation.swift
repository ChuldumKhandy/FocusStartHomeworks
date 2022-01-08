//
//  SettingNavigation.swift
//  FGI
//
//  Created by user on 08.01.2022.
//

import UIKit

final class SettingNavigation: UIView {
    private weak var controller: SettingVC?
    var backMenuVC: (() -> Void)?
    
    func loadView(controller: SettingVC) {
        self.controller = controller
        self.customizeNavigation()
    }
}

private extension SettingNavigation {
    func customizeNavigation() {
//        self.controller?.navigationController?.navigationBar.barTintColor = .white
//        self.controller?.navigationController?.navigationBar.shadowImage = UIImage()
        self.controller?.title = "Настройки"
        
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
