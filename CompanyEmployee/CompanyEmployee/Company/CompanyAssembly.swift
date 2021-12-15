//
//  CompanyAssembly.swift
//  CompanyEmployee
//
//  Created by user on 15.12.2021.
//

import UIKit

final class CompanyAssembly {
    static func build() -> UIViewController {
        let model = Company()
        let presenter = CompanyPresenter(companyModel: model)
        let controller = CompanyVC(presenter: presenter)
        return controller
    }
}
