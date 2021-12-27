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
    private let users: LogInUser
    private let router: LogInRouter
    
    init(users: LogInUser, router: LogInRouter) {
        self.users = users
        self.router = router
    }
}

extension LogInPresenter: ILogInPresenter {
    func loadView(controller: LogInVC, viewScene: ILogInView) {
        self.controller = controller
        self.viewScene = viewScene
    }
}
