//
//  CompanyPresenter.swift
//  CompanyEmployee
//
//  Created by user on 15.12.2021.
//

import Foundation

protocol ICompanyPresenter {
    func loadView(controller: CompanyVC, view: ICompanyView, navigation: ICompanyNavigation)
}

final class CompanyPresenter {
    private weak var controller: ICompanyVC?
    private weak var viewScene: ICompanyView?
    private weak var navigation: ICompanyNavigation?
    private let dataStoreManager: IDataStoreManager?


    init() {
        self.dataStoreManager = DataStoreManager()
    }
}

extension CompanyPresenter: ICompanyPresenter {
    func loadView(controller: CompanyVC,
                  view: ICompanyView,
                  navigation: ICompanyNavigation) {
        self.controller = controller
        self.viewScene = view
        self.navigation = navigation
        self.setHandler()
    }
}

private extension CompanyPresenter {
    func setHandler() {
        self.onTouched()
        self.addName()
        self.removeCompany()
    }
    
    func onTouched() {
        self.navigation?.addHandler = { [weak self] in
            self?.controller?.showAlert()
        }
        
        self.controller?.rowCountHandler = { [weak self] in
            let companies = self?.dataStoreManager?.obtainCompany()
            return companies?.count ?? 0
        }
        
        self.controller?.getNameHandler = { [weak self] index in
            let companies = self?.dataStoreManager?.obtainCompany()
            return companies?[index].name ?? "defaultName"
        }
    }
    
    func addName() {
        self.controller?.nameCompanyHandler = { [weak self] name in
            self?.dataStoreManager?.updateCompany(name: name)
            self?.viewScene?.tableView.reloadData()
        }
    }
    
    func removeCompany() {
        self.controller?.deleteHandler = { [weak self] index in
            self?.dataStoreManager?.removeCompany(index: index)
            self?.viewScene?.tableView.reloadData()
        }
    }
}
