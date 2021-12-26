//
//  FGIMapper.swift
//  FGI
//
//  Created by user on 26.12.2021.
//

import Foundation

class FGIMapper{
    static func fromDto(dtos: [FGIDto]) -> [FGI]{
        return dtos.map { (dto) -> FGI in
            FGI(dto: dto)
        }
    }
}


