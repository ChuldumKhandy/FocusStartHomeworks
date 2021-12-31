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
    private let urlValute = "https://valutes20211226150144.azurewebsites.net/api/valutes"
    private let dateFrom: String
    private let dateTo: String
    private let currency: String
    
    init(diagramModel: DiagramModel, currency: String, dateFrom: String, dateTo: String) {
        self.networkService = NetworkService()
        self.diagramModel = diagramModel
        self.currency = currency
        self.dateFrom = dateFrom
        self.dateTo = dateTo
    }
}

extension DiagramPresenter: IDiagramPresenter{
    func loadView(controller: DiagramVC, viewScene: IDiagramView) {
        self.controller = controller
        self.viewScene = viewScene
        self.loadData(currency: self.currency, dateFrom: self.dateFrom, dateTo: self.dateTo)
    }
}

private extension DiagramPresenter {    
    func getFGI() {
        if let fgi = self.diagramModel.getFGI() {
            self.viewScene?.setFGI(fgi: fgi)
        }
    }
    
    func loadData(currency: String, dateFrom: String, dateTo: String) {
        let encodedTexts = currency.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        if let encodedTexts = encodedTexts {
            if let url = URL(string: "\(self.urlValute)/GetValutes?dateFrom=\(dateFrom).2021&dateTo=\(dateTo).2021&currency=\(encodedTexts.replacingOccurrences(of: " ", with: "%20"))") {
                self.networkService.loadFGIes(from: url) { (result: Result<[FGIDto], Error>) in
                    switch result {
                    case .success(let model):
                        DispatchQueue.main.async {
                            self.diagramModel.setFGI(FGIes: FGIMapper.fromDto(dtos: model))
                            self.getFGI()
                        }
                    case .failure(let error):
                        print("[NETWORK] error Data is: \(error)")
                        DispatchQueue.main.async {
                            self.controller?.showAlert(message: "Некорректный ввод данных")
                        }
                    }
                }
            } else {
                self.controller?.showAlert(message: "Возникли проблемы с доступом к серверу")
            }
        }
    }
}
