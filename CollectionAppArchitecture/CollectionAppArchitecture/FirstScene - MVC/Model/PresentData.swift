//
//  PresentData.swift
//  CollectionAppArchitecture
//
//  Created by user on 28.11.2021.
//

import Foundation

class PresentCatsData {
    var cats = Cat.getCatsFromJson()
    
    var pname: String?
    var piconName: String?
    var pdescription: String?

    func getCount() -> Int {
        return cats.count
    }
    
    func getContentCell(indexPath: IndexPath) -> (String, String) {
        let name = cats[indexPath.row].name 
        let iconName = cats[indexPath.row].iconName

        return (name, iconName)
    }
    
    func getContent(indexPath: IndexPath) -> Cat {
        let cat = cats[indexPath.row]
        return cat
    }
}
