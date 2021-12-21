//
//  PriceScenePresenter.swift
//  CarShop
//
//  Created by user on 06.12.2021.
//

import Foundation

protocol IPriceScenePresenter {
    func loadView(controller: PriceSceneVC, view: IPriceSceneView)
}

final class PriceScenePresenter {
    private let cars: [Car]
    private var selectedCar: Car?
    private weak var controller: IPriceSceneVC?
    private weak var viewScene: IPriceSceneView?
    private weak var tableview: IPriceSceneTableView?
    
    init(cars: [Car]) {
        self.cars = cars
        self.selectedCar = cars.first
    }
}

extension PriceScenePresenter: IPriceScenePresenter{
    func loadView(controller: PriceSceneVC, view: IPriceSceneView) {
        self.controller = controller
        self.viewScene = view
        self.tableview = self.viewScene?.tableView
        
        self.setInfo()
        self.tableview?.countHandler = { [weak self] in
            return (self?.setBodyCount() ?? 0)
        }
        
        self.tableview?.bodyHandler = { [weak self] in
            return (self?.setBodies())!
        }
        
        self.tableview?.selectedBodyHandler = { [weak self] carBody in
            self?.selectedCar = self?.cars.first(where: { (Car) -> Bool in
                Car.body == carBody
            })
        }
        
        self.viewScene?.onCellTouchHandler = { [weak self] in
            self?.setInfo()
        }
    }
}

private extension PriceScenePresenter {
    func setBodyCount() -> Int {
        return cars.count
    }
    
    func setInfo() {
        self.viewScene?.setCarInfo(name: selectedCar?.image ?? "", price: selectedCar?.price ?? "")
    }
    
    func setBodies() -> [String] {
        return self.cars.map({(car: Car) -> String in car.body})
    }
}
