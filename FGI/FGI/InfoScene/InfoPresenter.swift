//
//  InfoPresenter.swift
//  FGI
//
//  Created by user on 23.12.2021.
//

import Foundation

protocol IInfoPresenter {
    func loadView(controller: InfoVC, viewScene: IInfoView, navigation: IInfoNavigation)
}

final class InfoPresenter {
    private weak var controller: IInfoVC?
    private weak var viewScene: IInfoView?
    private weak var navigation: IInfoNavigation?
    private let router: IInfoRouter
    private let urlCNN = "https://money.cnn.com/data/fear-and-greed/"
    
    init(router: InfoRouter) {
        self.router = router
    }
}

extension InfoPresenter: IInfoPresenter {
    func loadView(controller: InfoVC, viewScene: IInfoView, navigation: IInfoNavigation) {
        self.controller = controller
        self.viewScene = viewScene
        self.navigation = navigation
        self.viewScene?.tappedOnLabelHandler = { [weak self] in
            self?.onTouchedLabel()
        }
        self.navigation?.backMenuVC = { [weak self] in
            self?.router.backVC()
        }
    }
}

private extension InfoPresenter {
    func onTouchedLabel() {
        self.controller?.followingLink(url: self.urlCNN)
    }
}
