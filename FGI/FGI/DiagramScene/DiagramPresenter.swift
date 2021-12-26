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
        self.setHandlers()
    }
}

private extension DiagramPresenter {
    func setHandlers() {
        self.getCurrencies()
        self.onTouched()
        //self.getFGI()
    }
    
    func onTouched() {
        if let view = self.viewScene {
            view.onTouchedHandler = { [weak self] selectedDate in
                switch selectedDate {
                case "Week":
                    self?.loadData(currency: view.getSelectedCurrency() ?? "",
                                  dateFrom: "12.19.2021",
                                  dateTo: "12.26.2021")
                    self?.getFGI()
                case "Month":
                    self?.loadData(currency: view.getSelectedCurrency() ?? "",
                                  dateFrom: "11.26.2021",
                                  dateTo: "12.26.2021")
                    self?.getFGI()
                case "Year":
                    self?.loadData(currency: view.getSelectedCurrency() ?? "",
                                  dateFrom: "01.01.2021",
                                  dateTo: "12.26.2021")
                    self?.getFGI()
                default:
                    print("Не выбран период")
                }
            }
        }
        //self.getFGI()
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
                    }
                case .failure(let error):
                    print("[NETWORK] error is: \(error)")
                }
            }
        } else {
            print("Проблемки с УРЛ")
        }
    }
    
    func loadData(currency: String, dateFrom: String, dateTo: String) {
        if let url = URL(string: "https://valutes20211226150144.azurewebsites.net/api/valutes/GetValutes?dateFrom=\(dateFrom)&dateTo=\(dateTo)&currency=\(currency.replacingOccurrences(of: " ", with: "%20"))") {
            self.networkService.loadFGIes(from: url) { (result: Result<[FGIDto], Error>) in
                switch result {
                case .success(let model):
                    //print("[NETWORK] model is: \(model)")
                    DispatchQueue.main.async {
                        self.diagramModel.setFGI(FGIes: FGIMapper.fromDto(dtos: model))
                    }
                case .failure(let error):
                    print("[NETWORK] error is: \(error)")
                }
            }
        } else {
            print("Проблемки с УРЛ 2")
        }
    }
}
