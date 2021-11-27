//
//  Cat.swift
//  CollectionAppArchitecture
//
//  Created by user on 26.11.2021.
//

import Foundation

class Cat: Decodable {
    var name: String
    var iconName: String
    var description: String
    
    static func getCatsFromJson() -> [Cat] {
        var cats = [Cat]()
        if let path = Bundle.main.path(forResource: "kitties", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            do {
                let jsonData = try Data(contentsOf: url)
                cats = try JSONDecoder().decode([Cat].self, from: jsonData)
            } catch {
                print("Error: \(error)")
            }
        }
        return cats
    }
}
