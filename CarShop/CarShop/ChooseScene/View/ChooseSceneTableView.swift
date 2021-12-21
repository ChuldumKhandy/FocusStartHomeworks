//
//  ChooseSceneTableView.swift
//  CarShop
//
//  Created by user on 21.12.2021.
//

import UIKit

protocol IChooseSceneTableView: UIView {
    var countHandler: (() -> Int)? { get set }
    var brandHandler: (() -> [String])? { get set }
    var nextVCHandler: (() -> Void)? { get set }
    var carBrandGiveBackHandler: ((String) -> Void)? { get set }
}

final class ChooseSceneTableView: UIView {
    private let tableView = UITableView(frame: .zero)
    
    var countHandler: (() -> Int)?
    var brandHandler: (() -> [String])?
    var nextVCHandler: (() -> Void)?
    var carBrandGiveBackHandler: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.tableView)
        self.customizeTableView()
        self.setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChooseSceneTableView: IChooseSceneTableView {
}

extension ChooseSceneTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.customizeHeader()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let carsBrands = self.brandHandler?()
        
        self.carBrandGiveBackHandler?(carsBrands![indexPath.row])
        self.nextVCHandler?()
    }
}

extension ChooseSceneTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let number = self.countHandler?()
        else { return 0 }
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: ChooseSceneCell.identifier, for: indexPath) as? ChooseSceneCell
        else {
            return UITableViewCell()
        }
        let brand = self.brandHandler?()
        cell.brandCar(brand: brand?[indexPath.row] ?? "Марка машины")
        if (indexPath.row % 2 != 0) {
            cell.colorImage()
        }
        return cell
    }
}

private extension ChooseSceneTableView {
    func customizeTableView() {
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedSectionHeaderHeight = CellMetrics.heightHeader.rawValue
        self.tableView.register(ChooseSceneCell.self, forCellReuseIdentifier: ChooseSceneCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func customizeHeader() -> UIView {
        let headerView = UIView()
        let titleLabel = UILabel()
        titleLabel.frame.size.height = CellMetrics.height.rawValue
        titleLabel.frame.size.width = CellMetrics.width.rawValue
        titleLabel.text = "Марку машины"
        titleLabel.font = UIFont(name: "Inter", size: FontSize.large.rawValue)
        titleLabel.font = titleLabel.font.withSize(FontSize.large.rawValue)
        titleLabel.textColor = .black
        headerView.backgroundColor = .white
        headerView.addSubview(titleLabel)
        return headerView
    }
    
    func setConstraint() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
