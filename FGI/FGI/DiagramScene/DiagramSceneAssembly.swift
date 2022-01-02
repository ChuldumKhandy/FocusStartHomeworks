//
//  DiagramSceneAssembly.swift
//  FGI
//
//  Created by user on 24.12.2021.
//

import Foundation
import UIKit

final class DiagramSceneAssembly {
    static func build(currency: String, dateFrom: String, dateTo: String) -> UIViewController {
        let router = DiagramRouter()
        let model = DiagramModel()
        let presenter = DiagramPresenter(diagramModel: model, router: router, currency: currency, dateFrom: dateFrom, dateTo: dateTo)
        let controller = DiagramVC(presenter: presenter)
        router.setRootController(controller: controller)
        return controller
    }
}
