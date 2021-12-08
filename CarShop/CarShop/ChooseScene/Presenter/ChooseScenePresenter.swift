//
//  Presenter.swift
//  CarShop
//
//  Created by user on 05.12.2021.
//

import Foundation

final class ChooseScenePresenter {
    private weak var car: CarModel?
    private weak var controller: ChooseSceneVC?
    
    init(car: CarModel, controller: ChooseSceneVC) {
        self.car = car
        self.controller = controller
    }

}
