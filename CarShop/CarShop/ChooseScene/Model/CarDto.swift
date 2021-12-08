//
//  CarDto.swift
//  CarShop
//
//  Created by user on 08.12.2021.
//

import Foundation

final class CarDto: Decodable {
    var brand: String
    var image: BodyCar
    var body: BodyCar
    var price: BodyCar

    static func getDtosFromJson() -> [CarDto] {
        var cars = [CarDto]()
        if let path = Bundle.main.path(forResource: "Cars", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            do {
                let jsonData = try Data(contentsOf: url)
                cars = try JSONDecoder().decode([CarDto].self, from: jsonData)
            } catch {
                print("Error: \(error)")
            }
        }
        return cars
    }
}

struct BodyCar: Decodable {
    var sedan: String
    var hatchback: String
    var coupe: String
    var cabrio: String
}
