//
//  ViewController.swift
//  CarShop
//
//  Created by user on 05.12.2021.
//

import UIKit

class ChooseSceneVC: UIViewController {
    private var viewScene: ChooseSceneView?
    private var navigationScene: ChooseSceneNavigation?
    var presenter: ChooseScenePresenter?
    
    init() {
        self.viewScene = ChooseSceneView(frame: UIScreen.main.bounds)
        self.navigationScene = ChooseSceneNavigation()
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
    }
}

extension ChooseSceneVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.viewScene?.customizeHeader()
    }
}

extension ChooseSceneVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.viewScene?.tableView.dequeueReusableCell(withIdentifier: ChooseSceneCell.identifier, for: indexPath) as? ChooseSceneCell
        else {
            return UITableViewCell()
        }
        
        return cell
    }
}
