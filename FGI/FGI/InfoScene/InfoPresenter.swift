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
}

extension InfoPresenter: IInfoPresenter {
    func loadView(controller: InfoVC, viewScene: IInfoView) {
        self.controller = controller
        self.viewScene = viewScene
        self.viewScene?.onTouchedHandler = { [weak self] in
            self?.onTouched()
        }
    }
}

private extension InfoPresenter {
    func onTouched() {
        self.controller?.followingLink(url: "https://money.cnn.com/data/fear-and-greed/")
    }
}
