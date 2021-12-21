//
//  ImageTableView.swift
//  DownloadImage
//
//  Created by user on 13.12.2021.
//

import UIKit

final class ImageTableView: UIView {
    let ImageTableView = UITableView(frame: .zero)
    var rowCountHandler: (() -> Int)?
    var dataHandler: ((Int) -> Data?)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.ImageTableView)
        self.customizeTableView()
        self.setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rowCountHandler?() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.ImageTableView.dequeueReusableCell(withIdentifier: ImageCell.identifier, for: indexPath) as? ImageCell
        else {
            return UITableViewCell()
        }
        let data = self.dataHandler?(indexPath.row)
        cell.setImage(data: data)
        return cell
    }
}

extension ImageTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MetricsTableView.heightCell.rawValue
    }
}

private extension ImageTableView {
    func customizeTableView() {
        self.ImageTableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.identifier)
        self.ImageTableView.dataSource = self
        self.ImageTableView.delegate = self
    }
    
    func setConstraint() {
        self.ImageTableView.translatesAutoresizingMaskIntoConstraints = false
        self.ImageTableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.ImageTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.ImageTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.ImageTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    
}
