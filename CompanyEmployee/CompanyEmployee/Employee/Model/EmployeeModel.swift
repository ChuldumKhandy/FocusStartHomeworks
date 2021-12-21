//
//  EmployeeModel.swift
//  CompanyEmployee
//
//  Created by user on 20.12.2021.
//

import Foundation

final class EmployeeModel {
    var name: String
    var age: Int
    var experience: Float?
    var company: Company
    
    init(name: String, age: Int, experience: Float?, company: Company) {
        self.name = name
        self.age = age
        self.experience = experience
        self.company = company
    }
    
    init?(employee: Employee) {
        self.name = employee.name
        self.age = Int(employee.age)
        self.experience = employee.experience as? Float
        self.company = employee.company
    }
    
    init() {
        self.name = "ERROR"
        self.age = 20
        self.experience = nil
        self.company = Company()
    }
}
