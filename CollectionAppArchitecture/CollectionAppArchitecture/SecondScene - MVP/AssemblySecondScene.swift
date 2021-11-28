//
//  AssemblySecondScene.swift
//  CollectionAppArchitecture
//
//  Created by user on 28.11.2021.
//

import Foundation
import UIKit

class AssemblySecondScene {
    static func build(cat: Cat) -> UIViewController {
        let catData = DetailCat(cat: cat)
        let presenter = DetailPresenter(cat: catData)
        let controller = DetailViewController(presenter: presenter)
        
        return controller
    }
}
