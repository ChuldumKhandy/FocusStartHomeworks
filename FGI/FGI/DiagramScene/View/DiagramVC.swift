//
//  DiagramVC.swift
//  FGI
//
//  Created by user on 23.12.2021.
//

import UIKit

protocol IDiagramVC: AnyObject {
    func showAlert(message: String)
    func showActivityIndicatory(startAnimating: Bool)
    func getTitle(currency: String, dateFrom: String, dateTo: String)
    func backMenuVC()
}

final class DiagramVC: UIViewController {
    private let viewScene: IDiagramView
    private let presenter: IDiagramPresenter
    private let navigation: DiagramNavigation
    var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    init(presenter: DiagramPresenter) {
        self.presenter = presenter
        self.navigation = DiagramNavigation()
        self.viewScene = DiagramView(frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.presenter.loadView(controller: self, viewScene: self.viewScene)
        self.navigation.loadView(controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.addSubview(self.viewScene)
    }
}

extension DiagramVC: IDiagramVC {
    func getTitle(currency: String, dateFrom: String, dateTo: String) {
        self.navigation.setTitle(currency: currency, dateFrom: dateFrom, dateTo: dateTo)
    }
    
    func backMenuVC() {
        self.navigation.backMenuVC = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Внимание", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Понятно", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showActivityIndicatory(startAnimating: Bool) {
        self.view.addSubview(activityIndicator)
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.color = .gray
        self.activityIndicator.center = view.center
        if startAnimating {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
    }
}
