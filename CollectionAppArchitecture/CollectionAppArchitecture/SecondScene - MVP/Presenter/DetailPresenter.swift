//
//  Presenter.swift
//  CollectionAppArchitecture
//
//  Created by user on 28.11.2021.
//

import Foundation

protocol IDetailPresenter {
    func loadPresenter(controller: DetailViewController, view: IDetailView)
    func sendContent()
}

final class DetailPresenter {
    var cat: IDetailCat
    private weak var controller: IDetailViewController?
    private weak var view: IDetailView?
    
    init(cat: IDetailCat) {
        self.cat = cat
    }

    func onTouched() {
        self.controller?.presentNextVC(nextVC: ModallyViewController())
    }
}

extension DetailPresenter: IDetailPresenter {
    func loadPresenter(controller: DetailViewController, view: IDetailView) {
        self.controller = controller
        self.view = view
        self.view?.onTouchedHandler = { [weak self] in
            self?.onTouched()
        }
    }
    
    func sendContent() {
        let name = cat.getName()
        self.view?.setTitle(title: name)
        
        let description = cat.getDescription()
        self.view?.setDescription(decription: description)
        
        let iconName = cat.getIconName()
        self.view?.setIconName(iconName: iconName)
    }
}
