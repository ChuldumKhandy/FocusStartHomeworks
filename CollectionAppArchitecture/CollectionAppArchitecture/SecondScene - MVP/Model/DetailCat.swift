//
//  CatData.swift
//  CollectionAppArchitecture
//
//  Created by user on 28.11.2021.
//

import Foundation

protocol IDetailCat {
    func getTitle() -> String
    func getIconName() -> String
    func getDescription() -> String
}

class DetailCat {
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
    func getTitle() -> String {
        let title = self.name
        return title
    }
    
    func getIconName() -> String {
        let iconName = self.iconName
        return iconName
    }
    
    func getDescription() -> String {
        let description = self.description
        return description
    }
}
