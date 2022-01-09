//
//  SettingPresenter.swift
//  FGI
//
//  Created by user on 08.01.2022.
//

import Foundation

protocol ISettingPresenter {
    func loadView(controller: SettingVC, viewScene: ISettingView, navigation: ISettingNavigation)
}

final class SettingPresenter {
    private weak var controller: ISettingVC?
    private weak var viewScene: ISettingView?
    private weak var navigation: ISettingNavigation?
    private let userStorage: IUserStorage
    private let router: ISettingRouter
    
    init(router: SettingRouter) {
        self.router = router
        self.userStorage = UserStorage()
    }
}

extension SettingPresenter: ISettingPresenter {
    func loadView(controller: SettingVC, viewScene: ISettingView, navigation: ISettingNavigation) {
        self.controller = controller
        self.viewScene = viewScene
        self.navigation = navigation
        self.signin()
        self.navigation?.backMenuVC = { [weak self] in
            self?.router.backVC()
        }
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
            let newUser = SettingUser(name: name, password: password, passwordState: passwordState)
            self?.userStorage.saveUser(user: newUser)
            self?.controller?.showAlert(message: "Настройки успешно сохранены")
        }
    }
}
