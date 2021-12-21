//
//  Cars.swift
//  CarShop
//
//  Created by user on 05.12.2021.
//

import Foundation

struct Car {
    var brand: String
    var image: String
    var body: String
    var price: String

    init(dto: CarDto){
        self.brand = dto.brand
        self.image = dto.image
        self.body = dto.body
        self.price = dto.price
    }
}
