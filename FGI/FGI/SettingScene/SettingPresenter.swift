//
//  SettingPresenter.swift
//  FGI
//
//  Created by user on 08.01.2022.
//

import Foundation

protocol ISettingPresenter {
    func loadView(controller: SettingVC, viewScene: ISettingView)
}

final class SettingPresenter {
    private weak var controller: ISettingVC?
    private weak var viewScene: ISettingView?
    private let userStorage: IUserStorage
    private let router: ISettingRouter
    
    init(router: SettingRouter) {
        self.router = router
        self.userStorage = UserStorage()
    }
}

extension SettingPresenter: ISettingPresenter {
    func loadView(controller: SettingVC, viewScene: ISettingView) {
        self.controller = controller
        self.viewScene = viewScene
        self.signin()
    }
}

private extension SettingPresenter {
    func signin() {
        self.viewScene?.signinHandler = { [weak self] name, password, passwordState in
            guard let name = name,
                  name.isEmpty == false,
                  let password = password,
                  password.isEmpty == false else {
                self?.controller?.showAlert(message: "Введите логин и пароль")
                return
            }
            self?.controller?.showActivityIndicatory(startAnimating: true)
            let newUser = SettingUser(name: name, password: password, passwordState: passwordState)
            self?.userStorage.saveUser(user: newUser)
            self?.controller?.showActivityIndicatory(startAnimating: false)
            //self?.router.next(controller: MenuSceneAssembly.build())
        }
    }
}
