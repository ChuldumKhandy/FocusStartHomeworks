//
//  PriceSceneVC.swift
//  CarShop
//
//  Created by user on 06.12.2021.
//

import UIKit

class PriceSceneVC: UIViewController {
    private var viewScene: PriceSceneView?
    private var navigationScene: PriceSceneNavigation?
    var presenter: PriceScenePresenter?
    var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    var countHandler: (() -> Int)?
    var bodyHandler: (() -> [String])?
    var selectedBodyHandler: ((String) -> Void)?
    
    init() {
        self.viewScene = PriceSceneView(frame: UIScreen.main.bounds)
        self.navigationScene = PriceSceneNavigation()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.navigationScene?.loadView(controller: self)
        if let view = viewScene {
            self.presenter?.loadView(view: view)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.showActivityIndicatory()
        self.viewScene?.tableView.delegate = self
        self.viewScene?.tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let view = viewScene {
            self.view.addSubview(view)
        }
    }
}

extension PriceSceneVC: UITableViewDelegate {    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.viewScene?.customizeHeader()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = self.viewScene?.tableView.cellForRow(at: indexPath) as? PriceSceneCell
        else { return }
        cell.selectedImageViewCell()
        let selectedBody = cell.bodyLabel.text
        self.selectedBodyHandler?(selectedBody!)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = self.viewScene?.tableView.cellForRow(at: indexPath) as? PriceSceneCell
        else { return }
        cell.radioImageView.image = UIImage(systemName: "circle")
    }
}

extension PriceSceneVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countHandler?() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.viewScene?.tableView.dequeueReusableCell(withIdentifier: PriceSceneCell.identifier, for: indexPath) as? PriceSceneCell
        else {
            return UITableViewCell()
        }
        if let bodies = self.bodyHandler?() {
            cell.setBody(body: bodies[indexPath.row])
        }
        return cell
    }
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
