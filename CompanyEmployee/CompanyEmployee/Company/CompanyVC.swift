//
//  ViewController.swift
//  CompanyEmployee
//
//  Created by user on 15.12.2021.
//

import UIKit

protocol ICompanyVC: AnyObject {
}

final class CompanyVC: UIViewController {
    private let viewScene: ICompanyView
    private let presenter: ICompanyPresenter
    
    init(presenter: ICompanyPresenter) {
        self.viewScene = CompanyView(frame: UIScreen.main.bounds)
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.loadView(controller: self, view: self.viewScene)
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CompanyCell.identifier, for: indexPath) as? CompanyCell else {
            return UITableViewCell() }
        return cell
    }
    
}

extension CompanyVC: ICompanyVC {
}
