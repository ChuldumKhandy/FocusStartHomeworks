//
//  DetailViewController.swift
//  CollectionAppArchitecture
//
//  Created by user on 26.11.2021.
//

import UIKit

protocol IDetailViewController: AnyObject {
    func presentNextVC(nextVC: UIViewController)
}

final class DetailViewController: UIViewController {
    private var detailView: IDetailView
    private var presenter: IDetailPresenter
    
    init(presenter: IDetailPresenter){
        self.detailView = DetailView(frame: UIScreen.main.bounds)
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(detailView)
        self.presenter.loadPresenter(controller: self, view: self.detailView)
        self.presenter.sendContent()
    }
}

extension DetailViewController: IDetailViewController {
    func presentNextVC(nextVC: UIViewController) {
        self.present(nextVC, animated: true, completion: nil)
    }
}
