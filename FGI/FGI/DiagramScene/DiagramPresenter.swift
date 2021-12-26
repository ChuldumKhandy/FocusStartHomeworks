//
//  DiagramPresenter.swift
//  FGI
//
//  Created by user on 24.12.2021.
//

import Foundation

protocol IDiagramPresenter {
    func loadView(controller: DiagramVC, viewScene: IDiagramView)
}

final class DiagramPresenter {
    private weak var controller: IDiagramVC?
    private weak var viewScene: IDiagramView?
    private let networkService: INetworkService
    private let diagramModel: IDiagramModel
    init(diagramModel: DiagramModel) {
        self.networkService = NetworkService()
        self.diagramModel = diagramModel
    }
}

extension DiagramPresenter: IDiagramPresenter{
    func loadView(controller: DiagramVC, viewScene: IDiagramView) {
        self.controller = controller
        self.viewScene = viewScene
        self.loadCurrencies()
        self.setHandlers()
    }
}

private extension DiagramPresenter {
    func setHandlers() {
        self.getCurrencies()
        
    }
    
    func onTouched() {

    }
    
    func getCurrencies() {
        if let currencies = self.diagramModel.getCurrencies() {
            self.viewScene?.passCurrency(currencies: currencies)
        }
    }
    
    
    
    func loadCurrencies() {
        let url = URL(string: "https://valutes20211226150144.azurewebsites.net/api/valutes/GetCurrencies")!
        self.networkService.loadCurriencies(from: url) { (result: Result<[String], Error>) in
            switch result {
            case .success(let model):
                print("[NETWORK] model is: \(model)")
                DispatchQueue.main.async {
                    self.diagramModel.setCurrencies(currencies: model)
                }
            case .failure(let error):
                print("[NETWORK] error is: \(error)")
            }
        }
    }
    
    func loadData(currency: String, dateFrom: String, dateTo: String) {
        let url = URL(string: "https://valutes20211226150144.azurewebsites.net/api/valutes/GetValutes?currency=\(currency)&dateFrom=\(dateFrom)&dateTo=\(dateTo)")!
        self.networkService.loadFGIes(from: url) { (result: Result<[FGIDto], Error>) in
            switch result {
            case .success(let model):
                print("[NETWORK] model is: \(model)")
                let fgies = FGIMapper.fromDto(dtos: model)
                DispatchQueue.main.async {
                    self.diagramModel.setFGI(FGIes: fgies)
                }
            case .failure(let error):
                print("[NETWORK] error is: \(error)")
            }
        }
    }
}
