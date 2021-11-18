//
//  Cat.swift
//  CollectionApp
//
//  Created by user on 17.11.2021.
//

import Foundation

struct itemCat: Decodable {
    var Cat: [Cat]
}
struct Cat: Decodable {
    var name: String
    var iconName: String
    var description: String
}
