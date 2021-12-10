//
//  Presenter.swift
//  CarShop
//
//  Created by user on 05.12.2021.
//

import Foundation

final class ChooseScenePresenter {
    private let router: ChooseSceneRouter?
    private let car: CarModel?
    var carNextVC: Car?
    private weak var controller: ChooseSceneVC?
    private weak var viewScene: ChooseSceneView?
    
    init(router: ChooseSceneRouter, car: CarModel, controller: ChooseSceneVC) {
        self.router = router
        self.car = car
        self.controller = controller
    }
    
    func loadView( view: ChooseSceneView) {
        self.viewScene = view
        
        self.controller?.countHandler = { [weak self] in
            return (self?.setCarsCount() ?? 0)
        }
        
        self.controller?.carHandler = { [weak self] in
            return (self?.setCar())!
        }
        
        self.controller?.carGiveBackHandler = { [weak self] car in
            self?.carNextVC = car
        }
        
        self.controller?.nextVCHandler = { [weak self] in
            if let car = self?.carNextVC {
                self?.router?.setTargerController(controller: PriceSceneAssembly.build(car: car))
                self?.router?.next()
            }
        }
    }
}

private extension ChooseScenePresenter {
    func setCarsCount() -> Int {
        return self.car?.cars?.count ?? 0
    }
    
    func setCar() -> [Car] {
        return self.car!.cars!
    }
    
    func nextVC() {
        self.controller?.navigationController?.pushViewController(PriceSceneVC(), animated: true)
    }
}
