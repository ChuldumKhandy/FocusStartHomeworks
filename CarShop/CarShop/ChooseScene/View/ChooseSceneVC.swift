//
//  ViewController.swift
//  CarShop
//
//  Created by user on 05.12.2021.
//

import UIKit

protocol IChooseSceneVC: AnyObject {
}

class ChooseSceneVC: UIViewController {
    private let viewScene: IChooseSceneView
    private let navigationScene: ChooseSceneNavigation
    private let presenter: IChooseScenePresenter
    
    init(presenter: ChooseScenePresenter) {
        self.viewScene = ChooseSceneView(frame: UIScreen.main.bounds)
        self.navigationScene = ChooseSceneNavigation()
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationScene.customizeNav()
        self.view.addSubview(self.viewScene)
    }
}

extension ChooseSceneVC: IChooseSceneVC {
}

