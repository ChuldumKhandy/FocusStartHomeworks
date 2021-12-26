//
//  DiagramModel.swift
//  FGI
//
//  Created by user on 24.12.2021.
//

import Foundation

protocol IDiagramModel {
    func setCurrencies(currencies: [String])
    func getCurrencies() -> [String]?
    func getFGI() -> [FGI]?
    func setFGI(FGIes: [FGI])
}

final class DiagramModel {
    private var FGIes: [FGI]?
    private var currencies: [String]?

    init(){
    }
}

extension DiagramModel: IDiagramModel {
    func getFGI() -> [FGI]? {
        return self.FGIes
    }
    
    func setFGI(FGIes: [FGI]) {
        self.FGIes = FGIes
    }
    
    func setCurrencies(currencies: [String]) {
        self.currencies = currencies
    }
    
    func getCurrencies() -> [String]? {
        return self.currencies
    }
    
    
}

private extension DiagramModel {
}
