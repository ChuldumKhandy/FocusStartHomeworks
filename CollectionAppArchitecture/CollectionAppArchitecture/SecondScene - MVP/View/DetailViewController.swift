//
//  DetailViewController.swift
//  CollectionAppArchitecture
//
//  Created by user on 26.11.2021.
//

import UIKit

class DetailViewController: UIViewController {
    private var detailView: DetailView?
    
    init(presenter: DetailPresenter){
        super.init(nibName: nil, bundle: nil)
        self.detailView = DetailView(frame: UIScreen.main.bounds)
        if let detailView = detailView {
            self.view.addSubview(detailView)
        }
        self.detailView?.loadView(controller: self, presenter: presenter)
        self.detailView?.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
}
