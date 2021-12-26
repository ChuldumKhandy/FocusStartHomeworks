//
//  DiagramVC.swift
//  FGI
//
//  Created by user on 23.12.2021.
//

import UIKit

protocol IDiagramVC: AnyObject {
}

final class DiagramVC: UIViewController {
    private let viewScene: IDiagramView
    private let presenter: IDiagramPresenter
    
    init(presenter: DiagramPresenter) {
        self.presenter = presenter
        self.viewScene = DiagramView(frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.presenter.loadView(controller: self, viewScene: self.viewScene)
        self.viewScene.loadView(controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.addSubview(self.viewScene)
    }
}

extension DiagramVC: IDiagramVC {
}
