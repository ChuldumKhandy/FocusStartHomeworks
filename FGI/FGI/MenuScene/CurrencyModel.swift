//
//  CurrencyModel.swift
//  FGI
//
//  Created by user on 30.12.2021.
//

import Foundation

protocol ICurrencyModel {
    func setCurrencies(currencies: [String])
    func getCurrencies() -> [String]?
}

final class CurrencyModel {
    private var currencies: [String]?
}

extension CurrencyModel: ICurrencyModel{
    func setCurrencies(currencies: [String]) {
        self.currencies = currencies
    }
    
    func getCurrencies() -> [String]? {
        return self.currencies
    }
}
