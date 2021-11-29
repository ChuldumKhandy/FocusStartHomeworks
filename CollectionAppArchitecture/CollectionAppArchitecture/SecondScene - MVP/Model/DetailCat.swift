//
//  CatData.swift
//  CollectionAppArchitecture
//
//  Created by user on 28.11.2021.
//

import Foundation

protocol IDetailCat {
    func getName() -> String
    func getIconName() -> String
    func getDescription() -> String
}

final class DetailCat{
    var name: String
    var iconName: String
    var description: String
    
    init(cat: Cat) {
        self.name = cat.name
        self.iconName = cat.iconName
        self.description = cat.description
    }
}

extension DetailCat: IDetailCat {
    func getName() -> String {
        return self.name
    }
    
    func getIconName() -> String {
        return self.iconName
    }
    
    func getDescription() -> String {
        return self.description
    }
}
