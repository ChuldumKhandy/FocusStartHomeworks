//
//  EmployeeAssembly.swift
//  CompanyEmployee
//
//  Created by user on 16.12.2021.
//

import UIKit

final class EmployeeAssembly {
    static func build(company: Company) -> UIViewController {
        let presenter = EmployeePresenter(company: company)
        let controller = EmployeeVC(presenter: presenter)
        return controller
    }
}
