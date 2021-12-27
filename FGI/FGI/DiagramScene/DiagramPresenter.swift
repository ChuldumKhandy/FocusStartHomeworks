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
        self.loadCurrencies()
    }
}

extension DiagramPresenter: IDiagramPresenter{
    func loadView(controller: DiagramVC, viewScene: IDiagramView) {
        self.controller = controller
        self.viewScene = viewScene
        self.onTouched()
        self.controller?.openInfo()
        self.controller?.openAlert()
    }
}

private extension DiagramPresenter {
    func onTouched() {
        if let view = self.viewScene {
            view.onTouchedHandler = { [weak self] dateFrom, dateTo in
                guard let dateFrom = self?.isValidDate(date: dateFrom),
                      let dateTo = self?.isValidDate(date: dateTo) else {
                    self?.controller?.showAlert(message: "Некорректный ввод данных")
                    return
                }
                self?.loadData(currency: view.getSelectedCurrency() ?? "",
                               dateFrom: dateFrom,
                               dateTo: dateTo)
                self?.getFGI()
            }
        }
    }
    
    func getFGI() {
        if let fgi = self.diagramModel.getFGI() {
            self.viewScene?.setFGI(fgi: fgi)
        }
    }
    
    func getCurrencies() {
        if let currencies = self.diagramModel.getCurrencies() {
            self.viewScene?.passCurrencies(currencies: currencies)
        }
    }
    
    func loadCurrencies() {
        if let url = URL(string: "https://valutes20211226150144.azurewebsites.net/api/valutes/GetCurrencies") {
            self.networkService.loadCurriencies(from: url) { (result: Result<[String], Error>) in
                switch result {
                case .success(let model):
                    DispatchQueue.main.async {
                        self.diagramModel.setCurrencies(currencies: model)
                        self.getCurrencies()
                    }
                case .failure(let error):
                    print("[NETWORK] error Currencies is: \(error)")
                }
            }
        } else {
            self.controller?.showAlert(message: "Возникли проблемы с доступом к серверу")
        }
    }
    
    func loadData(currency: String, dateFrom: String, dateTo: String) {
        if let url = URL(string: "https://valutes20211226150144.azurewebsites.net/api/valutes/GetValutes?dateFrom=\(dateFrom).2021&dateTo=\(dateTo).2021&currency=\(currency.replacingOccurrences(of: " ", with: "%20"))") {
            self.networkService.loadFGIes(from: url) { (result: Result<[FGIDto], Error>) in
                switch result {
                case .success(let model):
                    DispatchQueue.main.async {
                        self.diagramModel.setFGI(FGIes: FGIMapper.fromDto(dtos: model))
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
    
    func isValidDate(date: String?) -> String? {
        guard let date = date,
              date.isEmpty == false,
              date.count < 6 else {
            return nil
        }
        let correct = self.dateForUrl(date: date)
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MM.dd"
        if dateFormatterGet.date(from: correct) != nil {
            return correct
        } else {
            return nil
        }
    }
    
    func dateForUrl(date: String) -> String {
        let dateComponets = date.components(separatedBy: ".")
        return dateComponets[1] + "." + dateComponets[0]
    }
}
