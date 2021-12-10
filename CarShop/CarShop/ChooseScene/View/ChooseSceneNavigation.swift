//
//  ChooseSceneNavigation.swift
//  CarShop
//
//  Created by user on 05.12.2021.
//

import UIKit

class ChooseSceneNavigation: UIView {
    private weak var controller: ChooseSceneVC?
    
    func loadView(controller: ChooseSceneVC) {
        self.controller = controller
        self.controller?.navigationController?.isNavigationBarHidden = true
    }
}
