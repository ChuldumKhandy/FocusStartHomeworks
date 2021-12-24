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
    private let dataStoreManager: ICompanyDataStoreManager?
    private let router: ICompanyRouter?

    init(router: CompanyRouter) {
        self.router = router
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
        self.nextVC()
    }
    
    func onTouched() {
        self.navigation?.addHandler = { [weak self] in
            self?.controller?.showAlert()
        }
        
        self.controller?.rowCountHandler = { [weak self] section in
            let sectionInfo = self?.dataStoreManager?.fetchCompanyResultController.sections?[section]
            return sectionInfo?.numberOfObjects ?? 0
        }
        
        self.controller?.getNameHandler = { [weak self] index in
            let company = self?.dataStoreManager?.fetchCompanyResultController.object(at: index)
            return company?.name ?? "Noname"
        }
    }
    
    func addName() {
        self.controller?.nameCompanyHandler = { [weak self] name in
            self?.dataStoreManager?.createCompany(name: name)
            self?.viewScene?.tableView.reloadData()
        }
    }
    
    func removeCompany() {
        self.controller?.deleteHandler = { [weak self] index in
            self?.dataStoreManager?.removeCompany(index: index)
            self?.viewScene?.tableView.reloadData()
        }
    }
    
    func nextVC() {
        self.controller?.nextVCHandler = { [weak self] index in
            if let company = self?.dataStoreManager?.fetchCompanyResultController.object(at: index) {
                self?.router?.setTargerController(controller: EmployeeAssembly.build(company: company))
                self?.router?.next()
            }
        }
    }
}
