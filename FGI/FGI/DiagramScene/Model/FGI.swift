//
//  FGI.swift
//  FGI
//
//  Created by user on 25.12.2021.
//

import Foundation

struct FGI: Decodable {
    var currency: String
    var date: String
    var value: String

    init(dto: FGIDto){
        self.currency = dto.currency
        self.date = dto.date
        self.value = dto.value
    }   
}
