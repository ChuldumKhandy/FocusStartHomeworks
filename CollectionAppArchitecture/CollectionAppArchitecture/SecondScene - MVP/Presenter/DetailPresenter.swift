//
//  Presenter.swift
//  CollectionAppArchitecture
//
//  Created by user on 28.11.2021.
//

import Foundation

class DetailPresenter {
    var cat: Cat?
    private var controller: DetailViewController?
    private var view: DetailView?
    
    func loadPresenter(controller: DetailViewController, view: DetailView) {
        self.controller = controller
        self.view = view
        self.view?.onTouchedHandler = { [weak self] in
            self?.onTouched()
        }
    }
    
    func getTitle() -> String {
        guard let name = cat?.name else { return "нет значения" }
        return name
    }
    
    func getDescription() -> String {
        guard let description = cat?.description else { return "нет значения" }
        return description
    }
    
    func getIconName() -> String {
        guard let iconName = cat?.iconName else { return "нет значения" }
        return iconName
    }
    func onTouched() {
//        self.present(ModallyViewController(), animated: true, completion: nil)
    }
}
