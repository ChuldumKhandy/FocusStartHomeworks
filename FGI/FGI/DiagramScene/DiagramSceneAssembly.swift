//
//  DiagramSceneAssembly.swift
//  FGI
//
//  Created by user on 24.12.2021.
//

import Foundation
import UIKit

final class DiagramSceneAssembly {
    static func build() -> UIViewController {
        let model = DiagramModel()
        let presenter = DiagramPresenter(diagramModel: model)
        let controller = DiagramVC(presenter: presenter)
        return controller
    }
}
