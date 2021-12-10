//
//  PriceScenePresenter.swift
//  CarShop
//
//  Created by user on 06.12.2021.
//

import Foundation

final class PriceScenePresenter {
    private let cars: [Car]?
    private var selectedCar: Car?
    private weak var controller: PriceSceneVC?
    private weak var viewScene: PriceSceneView?
    
    init(cars: [Car], controller: PriceSceneVC) {
        self.cars = cars
        self.selectedCar = cars.first
        self.controller = controller
    }
    func loadView(view: PriceSceneView) {
        self.viewScene = view
        self.setInfo()
        self.controller?.countHandler = { [weak self] in
            return (self?.setBodyCount() ?? 0)
        }
        
        self.controller?.bodyHandler = { [weak self] in
            return (self?.setBodies())!
        }
        
        self.controller?.selectedBodyHandler = { [weak self] carBody in
            self?.selectedCar = self?.cars?.first(where: { (Car) -> Bool in
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
        return cars?.count ?? 0
    }
    
    func setInfo() {
        self.viewScene?.setCarInfo(name: selectedCar?.image ?? "", price: selectedCar?.price ?? "")
    }
    
    func setBodies() -> [String] {
        return self.cars?.map({(car: Car) -> String in car.body}) ?? [""]
    }
    
    func nextVC() {
        self.controller?.navigationController?.pushViewController(PriceSceneVC(), animated: true)
    }
}
