//
//  MenuPresenter.swift
//  FGI
//
//  Created by user on 30.12.2021.
//

import Foundation

protocol IMenuPresenter {
    func loadView(controller: MenuVC, viewScene: IMenuView)
}

final class MenuPresenter {
    private weak var controller: IMenuVC?
    private weak var viewScene: IMenuView?
    private let networkService: IMenuNetworkService
    private let router: IMenuRouter
    private let currency: ICurrencyModel
    private let urlCurenncy = "https://valutes20211226150144.azurewebsites.net/api/valutes/GetCurrencies"
    
    init(currencyModel: CurrencyModel, router: MenuRouter) {
        self.networkService = MenuNetworkService()
        self.router = router
        self.currency = currencyModel
        self.loadCurrencies()
    }
}

extension MenuPresenter: IMenuPresenter {
    func loadView(controller: MenuVC, viewScene: IMenuView) {
        self.controller = controller
        self.viewScene = viewScene
        self.onTouched()
        self.controller?.openInfo()
        self.controller?.openAlert()
    }
}

private extension MenuPresenter {
    func onTouched() {
        if let view = self.viewScene {
            view.onTouchedHandler = { [weak self] dateFrom, dateTo in
                if dateFrom < dateTo {
                    guard let dateFrom = self?.convertDateFormater(dateFrom),
                          let dateTo = self?.convertDateFormater(dateTo) else {
                        return }
                    guard let currency = self?.currency.getCurrencies()?.first else {
                        return }
                    self?.router.nextVC(controller: DiagramSceneAssembly.build(currency: view.getSelectedCurrency() ?? currency,
                                                                               dateFrom: dateFrom,
                                                                               dateTo: dateTo))
                } else {
                    self?.controller?.showAlert(message: "Некорректный ввод данных")
                }
            }
        }
    }
    
    func getCurrencies() {
        if let currencies = self.currency.getCurrencies() {
            self.viewScene?.passCurrencies(currencies: currencies)
        }
    }
    
    func loadCurrencies() {
        if let url = URL(string: self.urlCurenncy) {
            self.networkService.loadCurriencies(from: url) { (result: Result<[String], Error>) in
                switch result {
                case .success(let model):
                    DispatchQueue.main.async {
                        self.currency.setCurrencies(currencies: model)
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
    
    func convertDateFormater(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd"
        return dateFormatter.string(from: date)
    }
}

