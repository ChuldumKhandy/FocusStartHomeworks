//
//  DiagramNavigation.swift
//  FGI
//
//  Created by user on 27.12.2021.
//

import UIKit

final class DiagramNavigation: UIView {
    private weak var controller: DiagramVC?
    private var title = ""
    var backMenuVC: (() -> Void)?
    
    func loadView(controller: DiagramVC) {
        self.controller = controller
        self.customizeNavigation()
    }
    
    func setTitle(currency: String, dateFrom: String, dateTo: String) {
        self.title = "\(currency): с \(dateFrom) по \(dateTo)"
    }
}

private extension DiagramNavigation {
    func customizeNavigation() {
        let leftBarItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(self.backVC))
        leftBarItem.tintColor = .black
        self.controller?.navigationItem.leftBarButtonItem = leftBarItem
        self.controller?.title = self.title
    }
    
    @objc func backVC() {
        self.backMenuVC?()
    }
}
