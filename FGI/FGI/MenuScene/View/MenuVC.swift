//
//  MenuVC.swift
//  FGI
//
//  Created by user on 30.12.2021.
//

import UIKit

protocol IMenuVC: AnyObject {
    func showAlert(message: String)
}

final class MenuVC: UIViewController {
    private let viewScene: IMenuView
    private let presenter: IMenuPresenter
    private let navigation: IMenuNavigation
    var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    init(presenter: MenuPresenter) {
        self.presenter = presenter
        self.navigation = MenuNavigation()
        self.viewScene = MenuView(frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.presenter.loadView(controller: self, viewScene: self.viewScene, navigation: self.navigation)
        self.navigation.loadView(controller: self)
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.addSubview(self.viewScene)
    }
}

extension MenuVC: IMenuVC {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Внимание", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Понятно", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
