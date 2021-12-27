//
//  LogInVC.swift
//  FGI
//
//  Created by user on 27.12.2021.
//

import UIKit

protocol ILogInVC: AnyObject {
    func showAlert(message: String)
    func showActivityIndicatory(startAnimating: Bool)
}

final class LogInVC: UIViewController {
    private let viewScene: ILogInView
    private let presenter: ILogInPresenter
    private let navigation: LogInNavigation
    var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    init(presenter: LogInPresenter) {
        self.viewScene = LogInView(frame: UIScreen.main.bounds)
        self.presenter = presenter
        self.navigation = LogInNavigation()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.loadView(controller: self, viewScene: self.viewScene)
        self.navigation.loadView(controller: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.addSubview(self.viewScene)
    }
}

extension LogInVC: ILogInVC {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Внимание", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Понятно", style: .default, handler: nil))
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
