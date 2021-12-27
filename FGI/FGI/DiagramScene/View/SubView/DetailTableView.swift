//
//  DetailView.swift
//  FGI
//
//  Created by user on 25.12.2021.
//

import UIKit

final class DetailTableView: UIView {
    private let tableView = UITableView(frame: .zero)
    private var fgi = [FGI]()
    var valueHandler: (([FGI]) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.tableView)
        self.configureTableView()
        self.setConstraints()
        self.valueHandler = { [weak self] FGIes in
            self?.fgi = FGIes
            self?.tableView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ViewConstraints.heightCell.rawValue
    }
}

extension DetailTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fgi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.identifier, for: indexPath) as? DetailCell else {
            return UITableViewCell() }
        let date = fgi[indexPath.row].date
        let value = fgi[indexPath.row].value
        cell.setValue(date: date, value: value)
        return cell
    }
}

private extension DetailTableView {
    func configureTableView() {
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = .white
        self.tableView.frame = self.bounds
        self.tableView.register(DetailCell.self, forCellReuseIdentifier: DetailCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
