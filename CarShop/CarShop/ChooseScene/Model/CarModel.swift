//
//  CarModel.swift
//  CarShop
//
//  Created by user on 08.12.2021.
//

import Foundation

final class CarModel{
    var cars: [Car]?

    init(){
        cars = getCars()
    }
    
    func uniqueBrand() -> [String] {
        var brands = [String]()
        if let cars = self.cars {
            for car in cars {
                if(!brands.contains(car.brand)){
                    brands.append(car.brand)
                }
            }
        }
        return brands
    }
}

private extension CarModel {
    func getCars() -> [Car] {
        var cars = [Car]()
        let dtos = CarDto.getDtosFromJson()
        for dto in dtos {
            cars.append(convertFromJson(dto: dto))
        }
        return cars
    }
     
    func convertFromJson(dto: CarDto) -> Car {
        return Car(dto: dto)
    }
}
