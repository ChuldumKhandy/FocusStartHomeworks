//
//  DiagramModel.swift
//  FGI
//
//  Created by user on 24.12.2021.
//

import Foundation

protocol IDiagramModel {
    func getFGI() -> [FGI]?
    func setFGI(FGIes: [FGI])
}

final class DiagramModel {
    private var FGIes: [FGI]?
}

extension DiagramModel: IDiagramModel {
    func getFGI() -> [FGI]? {
        return self.FGIes
    }
    
    func setFGI(FGIes: [FGI]) {
        self.FGIes = FGIes
    }
}
