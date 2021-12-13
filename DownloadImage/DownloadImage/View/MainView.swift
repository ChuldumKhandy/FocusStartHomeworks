//
//  MainView.swift
//  DownloadImage
//
//  Created by user on 13.12.2021.
//

import UIKit

protocol IMainView: UIView {
    var onTouchedHandler: (() -> Void)? { get set }
    
    func getDataTextField() -> String
    func getImageData(data: Data)
}

final class MainView: UIView {
    private let titleLabel = UILabel()
    private let urlTextField = UITextField()
    private let searchButton = UIButton()
    private let tableView = ImageTableView()
    
    var onTouchedHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customizeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MainView: IMainView {
  
    func getDataTextField() -> String {
        guard let text = self.urlTextField.text else { return  "" }
        return text
    }
    
    func getImageData(data: Data) {
        self.tableView.transmitImageData(data: data)
    }
}

private extension MainView {
    func customizeView() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.urlTextField)
        self.addSubview(self.searchButton)
        self.addSubview(self.tableView)
        self.customizeButton()
        self.customizeLabel()
        self.customizeTextField()
        self.setConstraints()
    }
    
    func customizeLabel() {
        self.titleLabel.text = "Picture"
        self.titleLabel.font = UIFont.systemFont(ofSize: 24)
        self.titleLabel.textColor = .black
    }
    
    func customizeTextField() {
        self.urlTextField.placeholder = "Введите URL картинки"
        self.urlTextField.backgroundColor = UIColor.init(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        self.urlTextField.borderStyle = .roundedRect
        self.urlTextField.layer.cornerRadius = MetricsView.radius.rawValue
        self.urlTextField.layer.masksToBounds = true
    }
    
    func customizeButton() {
        self.searchButton.setTitle("Поиск", for: .normal)
        self.searchButton.setTitleColor(.black, for: .normal)
        self.searchButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        self.searchButton.addTarget(self, action: #selector(self.touchedDown), for: .touchDown)
    }
    
    @objc private func touchedDown() {
        self.onTouchedHandler?()
    }
    
    func setConstraints() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor,
                                             constant: MetricsView.top.rawValue).isActive = true
        self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.urlTextField.translatesAutoresizingMaskIntoConstraints = false
        self.urlTextField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,
                                               constant: MetricsView.margin.rawValue).isActive = true
        self.urlTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                   constant: MetricsView.left.rawValue).isActive = true
        self.urlTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                    constant: -MetricsView.left.rawValue).isActive = true
        
        self.searchButton.translatesAutoresizingMaskIntoConstraints = false
        self.searchButton.topAnchor.constraint(equalTo: self.urlTextField.bottomAnchor,
                                               constant: MetricsView.margin.rawValue).isActive = true
        self.searchButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                   constant: MetricsView.left.rawValue).isActive = true
        self.searchButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                    constant: -MetricsView.left.rawValue).isActive = true
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.searchButton.bottomAnchor,
                                            constant: MetricsView.margin.rawValue).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                constant: MetricsView.left.rawValue).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                 constant: -MetricsView.left.rawValue).isActive = true
    }
}
