//
//  EmployeePresenter.swift
//  CompanyEmployee
//
//  Created by user on 16.12.2021.
//

import Foundation

protocol IEmployeePresenter {
    func loadView(controller: EmployeeVC, view: IEmployeeView, navigation: IEmployeeNavigation)
}

final class EmployeePresenter {
    private weak var controller: IEmployeeVC?
    private weak var viewScene: IEmployeeView?
    private weak var navigation: IEmployeeNavigation?
    private let dataStoreManager: IEmployeeDataStoreManager?
    private let company: Company
    private var employee: EmployeeModel?

    init(company: Company) {
        self.company = company
        self.dataStoreManager = DataStoreManager()
    }
}

extension EmployeePresenter: IEmployeePresenter {
    func loadView(controller: EmployeeVC,
                  view: IEmployeeView,
                  navigation: IEmployeeNavigation) {
        self.controller = controller
        self.viewScene = view
        self.navigation = navigation
        self.setHandler()
    }
}

private extension EmployeePresenter {
    func setHandler() {
        self.onTouched()
        self.addName()
        self.removeCompany()
    }
    
    func onTouched() {
        self.navigation?.addHandler = { [weak self] in
            self?.controller?.showAlert()
        }
        
        self.controller?.rowCountHandler = { [weak self] section in
            return self?.dataStoreManager?.fetchEmployeeResultController.sections?[section].numberOfObjects ?? 0
        }
        
        self.controller?.getInfoHandler = { [weak self] in
            if let company = self?.company {
                return self?.dataStoreManager?.getEmployee(for: company)
            }
            return EmployeeModel()
        }
    }
    
    func addName() {
        self.controller?.infoHandler = { [weak self] name, age, experience in
            guard let age = Int(age),
                  let experience = Float(experience),
                  let company = self?.company else {
            return  }
            self?.employee = EmployeeModel(name: name, age: age, experience: experience, company: company)
            if let employee = self?.employee {
                self?.dataStoreManager?.updateEmployee(newEmployee: employee)
            }
        }
    }
    
    func removeCompany() {
//        self.controller?.deleteHandler = { [weak self] index in
//            self?.dataStoreManager?.removeCompany(index: index)
//            self?.viewScene?.tableView.reloadData()
//        }
    }
}
