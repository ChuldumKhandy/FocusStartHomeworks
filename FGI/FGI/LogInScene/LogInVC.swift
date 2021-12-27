//
//  LogInVC.swift
//  FGI
//
//  Created by user on 27.12.2021.
//

import UIKit

protocol ILogInVC: AnyObject {
}

final class LogInVC: UIViewController {
    private let viewScene: ILogInView
    private let presenter: ILogInPresenter
    
    init(presenter: LogInPresenter) {
        self.viewScene = LogInView(frame: UIScreen.main.bounds)
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

extension LogInVC: ILogInVC {
}
