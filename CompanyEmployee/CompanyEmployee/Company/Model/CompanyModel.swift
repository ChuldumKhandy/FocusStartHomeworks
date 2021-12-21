//
//  CompanyModel.swift
//  CompanyEmployee
//
//  Created by user on 19.12.2021.
//

import Foundation

protocol ICompanyModel {
}

final class CompanyModel {
    var name: String
    var employee: Employee?
    
    init(name: String) {
        self.name = name
    }
}

extension CompanyModel: ICompanyModel {
}
