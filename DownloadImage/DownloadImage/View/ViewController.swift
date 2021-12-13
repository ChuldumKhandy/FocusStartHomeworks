//
//  ViewController.swift
//  DownloadImage
//
//  Created by user on 13.12.2021.
//

import UIKit

final class ViewController: UIViewController {
    private let viewScene: IMainView
    
    init() {
        self.viewScene = MainView(frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.addSubview(self.viewScene)
    }
}

