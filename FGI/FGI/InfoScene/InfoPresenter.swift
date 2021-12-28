//
//  InfoPresenter.swift
//  FGI
//
//  Created by user on 23.12.2021.
//

import Foundation

protocol IInfoPresenter {
    func loadView(controller: InfoVC, viewScene: IInfoView)
}

final class InfoPresenter {
    private weak var controller: IInfoVC?
    private weak var viewScene: IInfoView?
    private let router: IInfoRouter
    
    init(router: InfoRouter) {
        self.router = router
    }
}

extension InfoPresenter: IInfoPresenter {
    func loadView(controller: InfoVC, viewScene: IInfoView) {
        self.controller = controller
        self.viewScene = viewScene
        self.viewScene?.tappedOnLabelHandler = { [weak self] in
            self?.onTouchedLabel()
        }
        self.viewScene?.backHandler = { [weak self] in
            self?.router.backVC()
        }
    }
}

private extension InfoPresenter {
    func onTouchedLabel() {
        self.controller?.followingLink(url: "https://money.cnn.com/data/fear-and-greed/")
    }
}
