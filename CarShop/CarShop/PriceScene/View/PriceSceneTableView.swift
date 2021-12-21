//
//  PriceSceneTableView.swift
//  CarShop
//
//  Created by user on 21.12.2021.
//

import UIKit

protocol IPriceSceneTableView: UIView {
    var countHandler: (() -> Int)? { get set }
    var bodyHandler: (() -> [String])? { get set }
    var selectedBodyHandler: ((String) -> Void)? { get set }
}

final class PriceSceneTableView: UIView {
    private let tableView = UITableView(frame: .zero)
    var countHandler: (() -> Int)?
    var bodyHandler: (() -> [String])?
    var selectedBodyHandler: ((String) -> Void)?
    
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

extension PriceSceneTableView: IPriceSceneTableView {
}

extension PriceSceneTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.customizeHeader()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = self.tableView.cellForRow(at: indexPath) as? PriceSceneCell
        else { return }
        cell.selectedImageViewCell()
        let selectedBody = cell.bodyLabel.text
        self.selectedBodyHandler?(selectedBody!)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = self.tableView.cellForRow(at: indexPath) as? PriceSceneCell
        else { return }
        cell.radioImageView.image = UIImage(systemName: "circle")
    }
}

extension PriceSceneTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countHandler?() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: PriceSceneCell.identifier, for: indexPath) as? PriceSceneCell
        else {
            return UITableViewCell()
        }
        if let bodies = self.bodyHandler?() {
            cell.setBody(body: bodies[indexPath.row])
        }
        return cell
    }
}

private extension PriceSceneTableView {
    func customizeTableView() {
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedSectionHeaderHeight = CellMetrics.height.rawValue
        self.tableView.register(PriceSceneCell.self, forCellReuseIdentifier: PriceSceneCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func customizeHeader() -> UIView {
        let headerView = UIView()
        let titleLabel = UILabel()
        titleLabel.frame.size.height = CellMetrics.height.rawValue
        titleLabel.frame.size.width = CellMetrics.width.rawValue
        titleLabel.text = "Выберите тип кузова"
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
