//
//  LogInPresenter.swift
//  FGI
//
//  Created by user on 27.12.2021.
//

import Foundation

protocol ILogInPresenter {
    func loadView(controller: LogInVC, viewScene: ILogInView)
}

final class LogInPresenter {
    private weak var controller: ILogInVC?
    private weak var viewScene: ILogInView?
    private let userStorage: IUserStorage
    private let router: ILogInRouter
    
    init(router: LogInRouter) {
        self.router = router
        self.userStorage = UserStorage()
    }
}

extension LogInPresenter: ILogInPresenter {
    func loadView(controller: LogInVC, viewScene: ILogInView) {
        self.controller = controller
        self.viewScene = viewScene
        self.login()
        self.getName()
    }
}

private extension LogInPresenter {
    func getName() {
        self.viewScene?.setName?(self.userStorage.getName())
    }
    
    func login() {
        self.viewScene?.checkPasswordHandler = { [weak self] password in
            guard let password = password,
                  password.isEmpty == false else {
                self?.controller?.showAlert(message: "Введите пароль")
                return
            }
            guard ((self?.userStorage.checkPassword(passoword: password)) != nil) else {
                self?.controller?.showAlert(message: "Пароль не верен")
                return
            }
            self?.router.next(controller: MenuSceneAssembly.build())
        }
    }
}
