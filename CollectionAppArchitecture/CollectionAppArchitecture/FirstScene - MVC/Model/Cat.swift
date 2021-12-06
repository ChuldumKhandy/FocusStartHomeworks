//
//  Cat.swift
//  CollectionAppArchitecture
//
//  Created by user on 26.11.2021.
//

import Foundation

final class CatModel{
    var cats: [Cat]?
    
    init(){
        cats = getAndConvertFromJson()
    }
    
    private func getAndConvertFromJson() -> [Cat] {
        var cats = [Cat]()
        let dtos = CatDto.getDtosFromJson()
        for dto in dtos {
            cats.append(Cat(dto: dto))
        }
        return cats
    }
}

final class Cat {
    var name: String
    var iconName: String
    var description: String
      
    init(dto: CatDto){
        self.name = dto.name
        self.iconName = dto.iconName
        self.description = dto.description
    }
}


final class CatDto: Decodable {
    var name: String
    var iconName: String
    var description: String
    
    static func getDtosFromJson() -> [CatDto] {
        var cats = [CatDto]()
        if let path = Bundle.main.path(forResource: "kitties", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            do {
                let jsonData = try Data(contentsOf: url)
                cats = try JSONDecoder().decode([CatDto].self, from: jsonData)
            } catch {
                print("Error: \(error)")
            }
        }
        return cats
    }
}
