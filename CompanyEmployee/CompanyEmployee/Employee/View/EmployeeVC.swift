//
//  EmployeeVC.swift
//  CompanyEmployee
//
//  Created by user on 16.12.2021.
//

import UIKit

protocol IEmployeeVC: AnyObject {
    var infoHandler: ((String, String, String) -> Void)? { get set }
    var rowCountHandler: (() -> Int)? { get set }
    var getInfoHandler: ((IndexPath) -> Employee?)? { get set }
    var deleteHandler: ((Int) -> Void)? { get set }
    
    func addEmployeeAlert()
    func showAlert()
}

final class EmployeeVC: UIViewController {
    private let viewScene: IEmployeeView
    private let presenter: IEmployeePresenter
    private let navigation: IEmployeeNavigation
    var infoHandler: ((String, String, String) -> Void)?
    var rowCountHandler: (() -> Int)?
    var getInfoHandler: ((IndexPath) -> Employee?)?
    var deleteHandler: ((Int) -> Void)?
    
    init(presenter: IEmployeePresenter) {
        self.viewScene = EmployeeView(frame: UIScreen.main.bounds)
        self.presenter = presenter
        self.navigation = EmployeeNavigation()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.loadView(controller: self, view: self.viewScene, navigation: self.navigation)
        self.navigation.loadView(controller: self)
        self.viewScene.tableView.delegate = self
        self.viewScene.tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.backgroundColor = .white
        self.view.addSubview(self.viewScene)
    }
}

extension EmployeeVC: UITableViewDelegate {
}

extension EmployeeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rowCountHandler?() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCell.identifier, for: indexPath) as? EmployeeCell else {
            return UITableViewCell() }
        guard let employee = self.getInfoHandler?(indexPath) else {
            return UITableViewCell() }
        cell.setInfoEmployee(name: employee.name,
                             age: Int(employee.age),
                             experience: employee.experience as? Float)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.deleteHandler?(indexPath.row)
    }
}

extension EmployeeVC: IEmployeeVC {
    func addEmployeeAlert() {
        let alertController = UIAlertController(title: "Введите данные о сотруднике", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Имя сотрудника"
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Возраст сотрудника"
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Стаж сотрудника"
        }
        let saveAction = UIAlertAction(title: "Сохранить", style: .default, handler: { alert -> Void in
            if let name = alertController.textFields?[0].text,
               let age = alertController.textFields?[1].text,
               let experience = alertController.textFields?[2].text {
                    self.infoHandler?(name, age, experience)
            }
        })
        let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil )
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func showAlert() {
        let alert = UIAlertController(title: "Не заполнены обязательные поля", message: "Проверьте правильность ввода данных", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Понятно", style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}

