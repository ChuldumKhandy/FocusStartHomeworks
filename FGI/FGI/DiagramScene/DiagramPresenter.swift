//
//  DiagramPresenter.swift
//  FGI
//
//  Created by user on 24.12.2021.
//

import Foundation

protocol IDiagramPresenter {
    func loadView(controller: DiagramVC, viewScene: IDiagramView, navigation: IDiagramNavigation)
}

final class DiagramPresenter {
    private weak var controller: IDiagramVC?
    private weak var viewScene: IDiagramView?
    private weak var navigation: IDiagramNavigation?
    private let networkService: INetworkService
    private let diagramModel: IDiagramModel
    private let router: IDiagramRouter
    private let urlValute = "https://valutes20211226150144.azurewebsites.net/api/valutes"
    private let dateFrom: String
    private let dateTo: String
    private let currency: String
    
    init(diagramModel: DiagramModel, router: DiagramRouter, currency: String, dateFrom: String, dateTo: String) {
        self.networkService = DiagramNetworkService()
        self.diagramModel = diagramModel
        self.router = router
        self.currency = currency
        self.dateFrom = dateFrom
        self.dateTo = dateTo
    }
}

extension DiagramPresenter: IDiagramPresenter{
    func loadView(controller: DiagramVC, viewScene: IDiagramView, navigation: IDiagramNavigation) {
        self.controller = controller
        self.viewScene = viewScene
        self.navigation = navigation
        self.loadData(currency: self.currency, dateFrom: self.dateFrom, dateTo: self.dateTo)
        self.getTitle(currency: self.currency,
                      dateFrom: self.convertDateFormater(self.dateFrom),
                      dateTo: self.convertDateFormater(self.dateTo))
        self.backMenuVC()
    }
}

private extension DiagramPresenter {
    func getTitle(currency: String, dateFrom: String, dateTo: String) {
        self.navigation?.setTitle(currency: currency, dateFrom: dateFrom, dateTo: dateTo)
    }
    
    func backMenuVC() {
        self.navigation?.backMenuVC = { [weak self] in
            self?.router.backVC()
        }
    }
    
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
                            self.controller?.showActivityIndicatory(startAnimating: true)
                            self.diagramModel.setFGI(FGIes: FGIMapper.fromDto(dtos: model))
                            self.getFGI()
                            self.controller?.showActivityIndicatory(startAnimating: false)
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
    
    func convertDateFormater(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd"
        guard let _date = dateFormatter.date(from: date) else { return "" }
        dateFormatter.dateFormat = "dd.MM"
        return dateFormatter.string(from: _date)
    }
}
