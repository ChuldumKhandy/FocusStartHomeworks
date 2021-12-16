//
//  CompanyAssembly.swift
//  CompanyEmployee
//
//  Created by user on 15.12.2021.
//

import UIKit

final class CompanyAssembly {
    static func build() -> UIViewController {
        let presenter = CompanyPresenter()
        let controller = CompanyVC(presenter: presenter)
        return controller
    }
}
