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
    
    var countHandler: (() -> Int)?
    var brandHandler: (() -> [String])?
    var nextVCHandler: (() -> Void)?
    var carBrandGiveBackHandler: ((String) -> Void)?
    
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
        self.navigationScene?.loadView(controller: self)
        if let view = viewScene {
            self.presenter?.loadView(view: view)
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let carsBrands = self.brandHandler?()
        
        self.carBrandGiveBackHandler?(carsBrands![indexPath.row])
        self.nextVCHandler?()
    }
}

extension ChooseSceneVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let number = self.countHandler?()
        else { return 0 }
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.viewScene?.tableView.dequeueReusableCell(withIdentifier: ChooseSceneCell.identifier, for: indexPath) as? ChooseSceneCell
        else {
            return UITableViewCell()
        }
        let brand = self.brandHandler?()
        cell.brandCar(brand: brand![indexPath.row])
        if (indexPath.row % 2 != 0) {
            cell.colorImage()
        }
        return cell
    }
}

