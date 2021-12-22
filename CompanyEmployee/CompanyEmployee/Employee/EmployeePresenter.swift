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
        self.createEmployee()
        self.removeEmployee()
    }
    
    func onTouched() {
        self.navigation?.addHandler = { [weak self] in
            self?.controller?.addEmployeeAlert()
        }
        
        self.controller?.rowCountHandler = { [weak self] in
            let employees = self?.getEmployees()
            return employees?.count ?? 0
        }
        
        self.controller?.getInfoHandler = { [weak self] index in
            let employees = self?.getEmployees()
            return employees?[index.row]
        }
    }
    
    func createEmployee() {
        self.controller?.infoHandler = { [weak self] name, age, experience in
            guard let age = Int16(age),
                  let company = self?.company
            else {
                self?.controller?.showAlert()
                return }
            if let experience = Float(experience) {
                self?.dataStoreManager?.createEmployee(name: name, age: age, experience: experience as NSNumber, company: company)
            } else {
                self?.dataStoreManager?.createEmployee(name: name, age: age, experience: nil, company: company)
            }
            self?.viewScene?.tableView.reloadData()
        }
    }
    
    func removeEmployee() {
        self.controller?.deleteHandler = { [weak self] index in
            self?.dataStoreManager?.removeEmployee(index: index)
            self?.viewScene?.tableView.reloadData()
        }
    }
    
    func getEmployees() -> [Employee] {
        return self.dataStoreManager?.getEmployee(company: self.company) ?? []
    }
}
