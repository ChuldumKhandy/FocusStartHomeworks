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
        self.navigationScene?.loadNavigaition(controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewScene?.tableView.delegate = self
        self.viewScene?.tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let view = viewScene {
            self.view.addSubview(view)
        }
        viewScene?.tableView.reloadData()
    }
}

extension PriceSceneVC: UITableViewDelegate {    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.viewScene?.customizeHeader()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = self.viewScene?.tableView.cellForRow(at: indexPath) as? PriceSceneCell
        else { return }
        cell.changeImageViewCell()
    }
}

extension PriceSceneVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.viewScene?.tableView.dequeueReusableCell(withIdentifier: PriceSceneCell.identifier, for: indexPath) as? PriceSceneCell
        else {
            return UITableViewCell()
        }
        
        return cell
    }
}
