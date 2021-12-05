//
//  ChooseSceneNavigation.swift
//  CarShop
//
//  Created by user on 05.12.2021.
//

import UIKit

class ChooseSceneNavigation: UIView {
    private weak var controller: ChooseSceneVC?
    
    func loadNavigaition(controller: ChooseSceneVC) {
        self.controller = controller
        self.customizeNavigation()
    }
}

private extension ChooseSceneNavigation {
    func customizeNavigation() {
        self.controller?.navigationItem.title = "Выберите"
        self.controller?.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

