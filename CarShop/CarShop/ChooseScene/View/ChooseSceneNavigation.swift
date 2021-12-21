//
//  ChooseSceneNavigation.swift
//  CarShop
//
//  Created by user on 05.12.2021.
//

import UIKit

final class ChooseSceneNavigation: UIView {
    private weak var controller: ChooseSceneVC?
    
    func loadView(controller: ChooseSceneVC) {
        self.controller = controller
        self.customizeNav()
    }
    
    func customizeNav() {
        self.controller?.navigationController?.isNavigationBarHidden = true
    }
}
