//
//  InfoNavigation.swift
//  FGI
//
//  Created by user on 09.01.2022.
//

import UIKit

protocol IInfoNavigation: UIView {
    var backMenuVC: (() -> Void)? { get set }
    func loadView(controller: InfoVC)
}

final class InfoNavigation: UIView {
    private weak var controller: InfoVC?
    var backMenuVC: (() -> Void)?
}

extension InfoNavigation: IInfoNavigation {
    func loadView(controller: InfoVC) {
        self.controller = controller
        self.customizeNavigation()
    }
}

private extension InfoNavigation {
    func customizeNavigation() {
        self.controller?.title = InfoText.title.rawValue
        self.controller?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: FontSize.title.rawValue)]
        
        let leftBarItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(self.backVC))
        leftBarItem.tintColor = .black
        self.controller?.navigationItem.leftBarButtonItem = leftBarItem
    }
    
    @objc func backVC() {
        self.backMenuVC?()
    }
}
