//
//  Presenter.swift
//  CollectionAppArchitecture
//
//  Created by user on 28.11.2021.
//

import Foundation

protocol IDetailPresenter {
    func loadView(controller: DetailViewController, view: IDetailView)
}

final class DetailPresenter {
    var cat: IDetailCat
    private weak var controller: DetailViewController?
    private weak var view: IDetailView?
    
    init(cat: IDetailCat) {
        self.cat = cat
    }

    func onTouched() {
        self.controller?.present(ModallyViewController(), animated: true, completion: nil)
    }
}

extension DetailPresenter: IDetailPresenter {
    func loadView(controller: DetailViewController, view: IDetailView) {
        self.controller = controller
        self.view = view
        self.view?.onTouchedHandler = { [weak self] in
            self?.onTouched()
        }
        let detailCat = cat.getDetailCat()
        self.view?.setCatInformation(title: detailCat.name,
                                     decription: detailCat.description,
                                     iconName: detailCat.iconName)
    }
}
