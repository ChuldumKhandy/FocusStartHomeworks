//
//  MainPresenter.swift
//  DownloadImage
//
//  Created by user on 13.12.2021.
//

import Foundation

protocol IMainPresenter {
    func loadView(view: IMainView)
}

final class MainPresenter {
    private weak var controller: IMainVC?
    private weak var viewScene: IMainView?
    private let networkService: INetworkService
    private let imageModel: ImageModel?
    
    init(imageModel: ImageModel, controller: IMainVC) {
        self.networkService = NetworkService()
        self.controller = controller
        self.imageModel = imageModel
    }
}

extension MainPresenter: IMainPresenter {
    func loadView(view: IMainView) {
        self.viewScene = view
        self.setHandlers()
    }
}

private extension MainPresenter {
    func setHandlers() {
        self.viewScene?.onTouchedHandler = { [weak self] in
            self?.onTouched()
        }
    }
    
    func onTouched() {
        guard let viewScene = self.viewScene,
              let imageModel = self.imageModel,
              let controller = self.controller
        else {
            return
        }
        let urlString = viewScene.getDataTextField()
        if controller.canOpenURL(urlString) {
            guard let url = URL(string: urlString)
            else {
                return
            }
            imageModel.setUrl(url: url)
            let urls = imageModel.getUrls()
            viewScene.getNumberOfCell(number: urls.count)
            self.loadImage()
        } else {
            self.controller?.showAlert()
        }
    }
    
    func loadImage() {
        guard let urlImage = self.imageModel?.getUrls().last
        else {
            return
        }
        self.networkService.loadImage(from: urlImage) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.viewScene?.getImageData(data: data)
                }
            case .failure(let error):
                print("[NETWORK] error is: \(error)")
            }
        }
    }
}
