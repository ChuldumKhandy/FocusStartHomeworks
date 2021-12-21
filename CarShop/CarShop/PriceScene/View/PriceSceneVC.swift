//
//  PriceSceneVC.swift
//  CarShop
//
//  Created by user on 06.12.2021.
//

import UIKit

protocol IPriceSceneVC: AnyObject {
}

final class PriceSceneVC: UIViewController {
    private let viewScene: IPriceSceneView
    private let navigationScene: PriceSceneNavigation
    private var presenter: IPriceScenePresenter
    var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    init(presenter: PriceScenePresenter) {
        self.viewScene = PriceSceneView(frame: UIScreen.main.bounds)
        self.navigationScene = PriceSceneNavigation()
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.navigationScene.loadView(controller: self)
        self.presenter.loadView(controller: self, view: self.viewScene)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.showActivityIndicatory()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.addSubview(self.viewScene)
    }
}

extension PriceSceneVC: IPriceSceneVC {
}

private extension PriceSceneVC {
    func showActivityIndicatory() {
        self.view.addSubview(activityIndicator)
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.center = view.center
        self.activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10) {
            self.activityIndicator.stopAnimating()
        }
    }
}
