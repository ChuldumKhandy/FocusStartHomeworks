//
//  DiagramNavigation.swift
//  FGI
//
//  Created by user on 27.12.2021.
//

import UIKit

final class DiagramNavigation: UIView {
    private weak var controller: DiagramVC?
    var openInfoSceneHandler: (() -> Void)?
    var openAlerteHandler: (() -> Void)?
    
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
        self.controller?.navigationController?.isNavigationBarHidden = false
        
        self.leftBarItem()
        self.rightBarItem()
    }
    
    func rightBarItem() {
        let rightBarItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(self.openInfoScene))
        rightBarItem.tintColor = .black
        self.controller?.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    func leftBarItem() {
        let leftBarItem = UIBarButtonItem(image: UIImage(systemName: "questionmark.circle"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(self.openAlert))
        leftBarItem.tintColor = .black
        self.controller?.navigationItem.leftBarButtonItem = leftBarItem
    }
    
    @objc func openInfoScene() {
        self.openInfoSceneHandler?()
    }
    
    @objc func openAlert() {
        self.openAlerteHandler?()
    }
}
