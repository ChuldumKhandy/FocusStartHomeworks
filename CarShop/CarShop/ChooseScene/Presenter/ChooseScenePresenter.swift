//
//  Presenter.swift
//  CarShop
//
//  Created by user on 05.12.2021.
//

import Foundation

protocol IChooseScenePresenter {
    func loadView(controller: ChooseSceneVC, view: IChooseSceneView)
}

final class ChooseScenePresenter {
    private let router: ChooseSceneRouter
    private let car: CarModel
    var carsNextVC: [Car]?
    
    private weak var controller: IChooseSceneVC?
    private weak var viewScene: IChooseSceneView?
    private weak var tableView: IChooseSceneTableView?
    
    init(router: ChooseSceneRouter, car: CarModel) {
        self.router = router
        self.car = car
    }
}

extension ChooseScenePresenter: IChooseScenePresenter {
    func loadView(controller: ChooseSceneVC, view: IChooseSceneView) {
        self.controller = controller
        self.viewScene = view
        self.tableView = self.viewScene?.tableView
        
        self.tableView?.countHandler = { [weak self] in
            let brands = (self?.setBrands())!
            return brands.count
        }
        
        self.tableView?.brandHandler = { [weak self] in
            return (self?.setBrands() ?? ["Марка машины"])
        }
        
        self.tableView?.carBrandGiveBackHandler = { [weak self] carBrand in
           self?.carsNextVC = self?.car.cars?.filter({ (Car) -> Bool in
                Car.brand == carBrand
            })
        }
        
        self.tableView?.nextVCHandler = { [weak self] in
            if let cars = self?.carsNextVC {
                self?.router.setTargerController(controller: PriceSceneAssembly.build(cars: cars))
                self?.router.next()
            }
        }
    }
}

private extension ChooseScenePresenter {
    func setCarsCount() -> Int {
        return self.car.uniqueBrand().count
    }
    
    func setBrands() -> [String] {
        return self.car.uniqueBrand()
    }
}
