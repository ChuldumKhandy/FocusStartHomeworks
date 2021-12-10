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
        cars = getAndConvertFromJson()
    }
}

private extension CarModel {
    func getAndConvertFromJson() -> [Car] {
        var cars = [Car]()
        let dtos = CarDto.getDtosFromJson()
        for dto in dtos {
            cars.append(Car(dto: dto))
        }
        return cars
    }
}
