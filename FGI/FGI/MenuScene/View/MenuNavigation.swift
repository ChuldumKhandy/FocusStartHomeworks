//
//  MenuNavigation.swift
//  FGI
//
//  Created by user on 30.12.2021.
//

import UIKit

final class MenuNavigation: UIView {
    private weak var controller: MenuVC?
    var openInfoSceneHandler: (() -> Void)?
    var openSettingSceneHandler: (() -> Void)?
    
    func loadView(controller: MenuVC) {
        self.controller = controller
        self.customizeNavigation()
    }
}

private extension MenuNavigation {
    func customizeNavigation() {
        self.controller?.navigationController?.navigationBar.barTintColor = .white
        self.controller?.navigationController?.navigationBar.shadowImage = UIImage()
        self.controller?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: FontSize.title.rawValue)]
        self.controller?.title = "Индек страха и жадности"
        
        self.leftBarItem()
        self.rightBarItem()
    }
    
    func rightBarItem() {
        let rightBarItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(self.openInfoScene))
        rightBarItem.tintColor = .black
        self.controller?.navigationItem.rightBarButtonItem?.tintColor = .white
        self.controller?.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    func leftBarItem() {
        let leftBarItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(self.openSetting))
        leftBarItem.tintColor = .black
        self.controller?.navigationItem.leftBarButtonItem = leftBarItem
    }
    
    @objc func openInfoScene() {
        self.openInfoSceneHandler?()
    }
    
    @objc func openSetting() {
        self.openSettingSceneHandler?()
    }
}
