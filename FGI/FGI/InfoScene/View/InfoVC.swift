//
//  InfoVC.swift
//  FGI
//
//  Created by user on 23.12.2021.
//

import UIKit

protocol IInfoVC: AnyObject {
    func followingLink(url: String)
}

final class InfoVC: UIViewController {
    private let viewScene: IInfoView
    private let presenter: IInfoPresenter
    
    init(presenter: InfoPresenter) {
        self.viewScene = InfoView(frame: UIScreen.main.bounds)
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.loadView(controller: self, viewScene: self.viewScene)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.addSubview(self.viewScene)
    }
}

extension InfoVC: IInfoVC {
    func followingLink(url: String) {
        if let url = URL(string: url) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
}
