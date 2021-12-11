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
    var carsNextVC: [Car]?
    
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
            let brands = (self?.setBrands())!
            return brands.count
        }
        
        self.controller?.brandHandler = { [weak self] in
            return (self?.setBrands() ?? ["Марка машины"])
        }
        
        self.controller?.carBrandGiveBackHandler = { [weak self] carBrand in
           self?.carsNextVC = self?.car?.cars?.filter({ (Car) -> Bool in
                Car.brand == carBrand
            })
        }
        
        self.controller?.nextVCHandler = { [weak self] in
            if let cars = self?.carsNextVC {
                self?.router?.setTargerController(controller: PriceSceneAssembly.build(cars: cars))
                self?.router?.next()
            }
        }
    }
}

private extension ChooseScenePresenter {
    func setCarsCount() -> Int {
        return self.car?.uniqueBrand().count ?? 0
    }
    
    func nextVC() {
        self.controller?.navigationController?.pushViewController(PriceSceneVC(), animated: true)
    }
    
    func setBrands() -> [String] {
        return self.car?.uniqueBrand() ?? ["Марка машины"]
    }
    
}
