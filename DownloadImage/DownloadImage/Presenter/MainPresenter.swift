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
              let imageModel = self.imageModel
        else {
            return
        }
        guard let url = URL(string: viewScene.getDataTextField())
        else {
            return
        }
        imageModel.setUrl(url: url)
        let urls = imageModel.getUrls()
        viewScene.getNumberOfCell(number: urls.count)
        self.loadImage()
    }
    
    func loadImage() {
        guard let urlImage = self.imageModel?.getUrls()
        else {
            return
        }
        urlImage.forEach { (URL) in
            self.networkService.loadImage(from: URL) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.viewScene?.getImageData(data: data)
                    }
                case .failure(let error):
                    print("[NETWORK] error is: \(error)")
                    DispatchQueue.main.async {
                    }
                }
            }
        }
    }
}
