//
//  PriceNavigation.swift
//  CarShop
//
//  Created by user on 07.12.2021.
//

import UIKit

class PriceSceneNavigation: UIView {
    private weak var controller: PriceSceneVC?
    
    func loadView(controller: PriceSceneVC) {
        self.controller = controller
        self.customizeNavigation()
    }
}

private extension PriceSceneNavigation {
    func customizeNavigation() {
        self.controller?.navigationController?.navigationBar.barTintColor = .white
        self.controller?.navigationController?.navigationBar.shadowImage = UIImage()
        self.controller?.navigationController?.isNavigationBarHidden = false
        self.controller?.navigationController?.navigationBar.tintColor = MainPalette.greenPrimary
    }
}
