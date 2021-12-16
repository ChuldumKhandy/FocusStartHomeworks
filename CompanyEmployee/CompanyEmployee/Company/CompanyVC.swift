//
//  ViewController.swift
//  CompanyEmployee
//
//  Created by user on 15.12.2021.
//

import UIKit

protocol ICompanyVC: AnyObject {
    var nameCompanyHandler: ((String) -> Void)? { get set }
    var rowCountHandler: (() -> Int)? { get set }
    var getNameHandler: ((Int) -> String)? { get set }
    var deleteHandler: ((Int) -> Void)? { get set }
    
    func showAlert()
}

final class CompanyVC: UIViewController {
    private let viewScene: ICompanyView
    private let presenter: ICompanyPresenter
    private let navigation: ICompanyNavigation
    var nameCompanyHandler: ((String) -> Void)?
    var rowCountHandler: (() -> Int)?
    var getNameHandler: ((Int) -> String)?
    var deleteHandler: ((Int) -> Void)?
    
    init(presenter: ICompanyPresenter) {
        self.viewScene = CompanyView(frame: UIScreen.main.bounds)
        self.presenter = presenter
        self.navigation = CompanyNavigation()
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
        self.view.addSubview(self.viewScene)
    }
}

extension CompanyVC: UITableViewDelegate {
}

extension CompanyVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rowCountHandler?() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CompanyCell.identifier, for: indexPath) as? CompanyCell else {
            return UITableViewCell() }
        let name = self.getNameHandler?(indexPath.row)
        cell.setnameCompany(name: name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.deleteHandler?(indexPath.row)
    }
}

extension CompanyVC: ICompanyVC {
    func showAlert() {
        let alertController = UIAlertController(title: "Введите название компании", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Название компании"
        }
        let saveAction = UIAlertAction(title: "Сохранить", style: .default, handler: { alert -> Void in
            if let nameCompany = alertController.textFields?[0].text {
                self.nameCompanyHandler?(nameCompany)
            }
        })
        let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil )
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
