//
//  Model.swift
//  CollectionAppArchitecture
//
//  Created by user on 28.11.2021.
//

import Foundation

final class CatImage {
    private var catImageName: String?
    
    func getData() -> String {
        self.catImageName ?? "cat"
    }

    func set(catImageName: String) {
        self.catImageName = catImageName
    }
}
