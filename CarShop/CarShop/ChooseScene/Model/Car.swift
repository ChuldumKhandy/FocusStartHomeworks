//
//  Cars.swift
//  CarShop
//
//  Created by user on 05.12.2021.
//

import Foundation

final class Car {
    var brand: String
    var image: BodyCar
    var body: BodyCar
    var price: BodyCar

    init(dto: CarDto){
        self.brand = dto.brand
        self.image = dto.image
        self.body = dto.body
        self.price = dto.price
    }
}
