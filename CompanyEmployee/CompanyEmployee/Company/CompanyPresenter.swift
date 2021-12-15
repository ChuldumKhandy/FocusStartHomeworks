//
//  CompanyPresenter.swift
//  CompanyEmployee
//
//  Created by user on 15.12.2021.
//

import Foundation

protocol ICompanyPresenter {
    func loadView(controller: CompanyVC, view: ICompanyView)
}

final class CompanyPresenter {
    private weak var controller: ICompanyVC?
    private weak var viewScene: ICompanyView?
    private let companyModel: Company?

    init(companyModel: Company) {
        self.companyModel = companyModel
    }
}

extension CompanyPresenter: ICompanyPresenter {
    func loadView(controller: CompanyVC, view: ICompanyView) {
        self.controller = controller
        self.viewScene = view
    }
}
