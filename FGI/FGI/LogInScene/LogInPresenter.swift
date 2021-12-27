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
    private let coreDataManager: ICoreDataManager
    private let router: LogInRouter
    
    init(router: LogInRouter) {
        self.router = router
        self.coreDataManager = CoreDataManager()
    }
}

extension LogInPresenter: ILogInPresenter {
    func loadView(controller: LogInVC, viewScene: ILogInView) {
        self.controller = controller
        self.viewScene = viewScene
        self.login()
        self.signin()
    }
}

private extension LogInPresenter {
    func login() {
        self.viewScene?.loginHandler = { [weak self] login, password in
            guard let login = login,
                  login.isEmpty == false,
                  let password = password,
                  password.isEmpty == false else {
                self?.controller?.showAlert(message: "Введите логин и пароль")
                return
            }
            guard let user = self?.coreDataManager.getUser(login: login, password: password) else {
                self?.controller?.showAlert(message: "Пользователь не зарегистрирован или пароль не верен")
                return
            }
            self?.router.next(controller: DiagramSceneAssembly.build())
        }
    }
    
    func signin() {
        self.viewScene?.signinHandler = { [weak self] login, password in
            guard let login = login,
                  login.isEmpty == false,
                  let password = password,
                  password.isEmpty == false else {
                self?.controller?.showAlert(message: "Введите логин и пароль")
                return
            }
            guard self?.coreDataManager.getUser(login: login, password: password) == nil else {
                self?.controller?.showAlert(message: "Такой пользователь уже зарегистрирован")
                return
            }
            //self.uiView?.set(progress: true)
            let newUser = LogInUser(login: login, password: password)
            self?.coreDataManager.saveUser(user: newUser, completion: {
                //self.uiView?.set(progress: false)
                self?.router.next(controller: DiagramSceneAssembly.build())
            })
        }
    }
}
