//
//  SettingVC.swift
//  FGI
//
//  Created by user on 07.01.2022.
//

import UIKit

protocol ISettingVC: AnyObject {
    func showAlert(message: String)
    func showActivityIndicatory(startAnimating: Bool)
}

final class SettingVC: UIViewController {
    private let viewScene: ISettingView
    private let presenter: ISettingPresenter
    private let navigation: SettingNavigation
    var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    init(presenter: SettingPresenter) {
        self.viewScene = SettingView(frame: UIScreen.main.bounds)
        self.presenter = presenter
        self.navigation = SettingNavigation()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.loadView(controller: self, viewScene: self.viewScene)
        self.navigation.loadView(controller: self)
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.addSubview(self.viewScene)
    }
}

extension SettingVC: ISettingVC {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Внимание", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Понятно", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showActivityIndicatory(startAnimating: Bool) {
        self.view.addSubview(self.activityIndicator)
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
