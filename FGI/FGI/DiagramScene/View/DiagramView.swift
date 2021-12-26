//
//  DiagramView.swift
//  FGI
//
//  Created by user on 24.12.2021.
//

import UIKit

protocol IDiagramView: UIView {
    var onTouchedHandler: ((String) -> Void)? { get set }
    func passCurrencies(currencies: [String])
    func loadView(controller: IDiagramVC)
    func getSelectedCurrency() -> String?
    func setFGI(fgi: [FGI])
}

final class DiagramView: UIView {
    private weak var controller: IDiagramVC?
    private let titleLabel = UILabel()
    private let weekButton = UIButton()
    private let monthButton = UIButton()
    private let yearButton = UIButton()
    private let menuView = DropDownMenuView()
    private let graphView = GraphView()
    private let detailView = DetailTableView()
    
    var onTouchedHandler: ((String) -> Void)?
    
    private var selectedCurrency: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubviews()
        self.customizeLabel()
        self.customizeButtons()
        self.setConstraints()
        self.menuView.selectedCurrencyHandler = { [weak self] selectedCurrency in
            self?.selectedCurrency = selectedCurrency
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DiagramView: IDiagramView {
    func loadView(controller: IDiagramVC) {
        self.controller = controller        
    }
    func passCurrencies(currencies: [String]) {
        self.menuView.getCurrenciesHandler = { [weak self] in
            return currencies
        }
    }
    func getSelectedCurrency() -> String? {
        return self.selectedCurrency
    }
    
    func setFGI(fgi: [FGI]) {        
        self.graphView.pointHandler?(fgi.map { (fgi) -> Float in
            fgi.value
        })
        self.detailView.valueHandler?(fgi)
    }
}

private extension DiagramView {
    func addSubviews() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.menuView)
        self.addSubview(self.graphView)
        self.addSubview(self.detailView)
        self.addSubview(self.weekButton)
        self.addSubview(self.monthButton)
        self.addSubview(self.yearButton)
    }
    
    func customizeLabel() {
        self.titleLabel.text = "Индек страха и жадности"
        self.titleLabel.font = .boldSystemFont(ofSize: 20)
        self.titleLabel.textAlignment = .center
        self.titleLabel.numberOfLines = 0
    }
    
    func customizeButtons() {
        UIButton.appearance().layer.cornerRadius = ViewConstraints.radius.rawValue
        UIButton.appearance().clipsToBounds = true
        UIButton.appearance().backgroundColor = .systemGray6
        UIButton.appearance().frame.size.width = self.graphView.frame.size.width / 4
        UIButton.appearance().frame.size.height = ViewConstraints.heightButtons.rawValue
        UIButton.appearance().setTitleColor(.black, for: .normal)
        
        self.weekButton.setTitle(" Неделя ", for: .normal)
        self.weekButton.addTarget(self, action: #selector(self.touchedWeek), for: .touchDown)
        self.monthButton.setTitle(" Месяц ", for: .normal)
        self.monthButton.addTarget(self, action: #selector(self.touchedMonth), for: .touchDown)
        self.yearButton.setTitle(" Год ", for: .normal)
        self.yearButton.addTarget(self, action: #selector(self.touchedYear), for: .touchDown)
    }
    
    @objc func touchedWeek() {
        self.onTouchedHandler?("Week")
    }
    @objc func touchedMonth() {
        self.onTouchedHandler?("Month")
    }
    @objc func touchedYear() {
        self.onTouchedHandler?("Year")
    }
    
    func setConstraints() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: ViewConstraints.top.rawValue).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ViewConstraints.left.rawValue).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ViewConstraints.left.rawValue).isActive = true
        
        self.menuView.translatesAutoresizingMaskIntoConstraints = false
        self.menuView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: ViewConstraints.margin.rawValue).isActive = true
        self.menuView.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor).isActive = true
        self.menuView.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor).isActive = true
        self.menuView.heightAnchor.constraint(equalToConstant: ViewConstraints.heightMenu.rawValue).isActive = true
        
        self.weekButton.translatesAutoresizingMaskIntoConstraints = false
        self.weekButton.topAnchor.constraint(equalTo: self.menuView.bottomAnchor, constant: ViewConstraints.marginSmall.rawValue).isActive = true
        self.weekButton.leadingAnchor.constraint(equalTo: self.menuView.leadingAnchor, constant: ViewConstraints.left.rawValue).isActive = true
        self.weekButton.trailingAnchor.constraint(equalTo: self.monthButton.leadingAnchor, constant: -ViewConstraints.left.rawValue).isActive = true
        
        self.monthButton.translatesAutoresizingMaskIntoConstraints = false
        self.monthButton.topAnchor.constraint(equalTo: self.menuView.bottomAnchor, constant: ViewConstraints.marginSmall.rawValue).isActive = true
        self.monthButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.yearButton.translatesAutoresizingMaskIntoConstraints = false
        self.yearButton.topAnchor.constraint(equalTo: self.menuView.bottomAnchor, constant: ViewConstraints.marginSmall.rawValue).isActive = true
        self.yearButton.leadingAnchor.constraint(equalTo: self.monthButton.trailingAnchor, constant: ViewConstraints.left.rawValue).isActive = true
        self.yearButton.trailingAnchor.constraint(equalTo: self.menuView.trailingAnchor, constant: -ViewConstraints.left.rawValue).isActive = true
        
        self.graphView.translatesAutoresizingMaskIntoConstraints = false
        self.graphView.topAnchor.constraint(equalTo: self.weekButton.bottomAnchor, constant: ViewConstraints.marginSmall.rawValue).isActive = true
        self.graphView.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor).isActive = true
        self.graphView.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor).isActive = true
        self.graphView.heightAnchor.constraint(equalToConstant: ViewConstraints.heightGraph.rawValue).isActive = true
        
        self.detailView.translatesAutoresizingMaskIntoConstraints = false
        self.detailView.topAnchor.constraint(equalTo: self.graphView.bottomAnchor, constant: ViewConstraints.marginSmall.rawValue).isActive = true
        self.detailView.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor).isActive = true
        self.detailView.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor).isActive = true
        self.detailView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -ViewConstraints.bottom.rawValue).isActive = true
    }
}
