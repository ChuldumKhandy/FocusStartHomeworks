//
//  DiagramView.swift
//  FGI
//
//  Created by user on 24.12.2021.
//

import UIKit

protocol IDiagramView: UIView {
    var onTouchedHandler: (([String]) -> Void)? { get set }
    func passCurrencies(currencies: [String])
    func loadView(controller: IDiagramVC)
    func getSelectedCurrency() -> String?
    func setFGI(fgi: [FGI])
}

final class DiagramView: UIView {
    private weak var controller: IDiagramVC?
    private let calculateButton = UIButton()
    private let dateFromTextField = UITextField()
    private let dateToTextField = UITextField()
    private let menuView = DropDownMenuView()
    private let graphView = GraphView()
    private let detailView = DetailTableView()
    
    var onTouchedHandler: (([String]) -> Void)?
    
    private var selectedCurrency: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubviews()
        self.customizeTextFields()
        self.customizeButton()
        self.setConstraints()
        self.graphView.isHidden = true
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
        self.menuView.getCurrenciesHandler?(currencies)
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
        self.addSubview(self.menuView)
        self.addSubview(self.graphView)
        self.addSubview(self.detailView)
        self.addSubview(self.calculateButton)
        self.addSubview(self.dateFromTextField)
        self.addSubview(self.dateToTextField)
    }
    
    func customizeTextFields() {
        UITextField.appearance().borderStyle = .roundedRect
        UITextField.appearance().layer.cornerRadius = ViewConstraints.radius.rawValue
        UITextField.appearance().layer.masksToBounds = true
        UITextField.appearance().frame.size.height = ViewConstraints.heightButtons.rawValue
        self.dateFromTextField.placeholder = "c: ММ.ДД"
        self.dateToTextField.placeholder = "по: ММ.ДД"
    }
    
    func customizeButton() {
        self.calculateButton.layer.cornerRadius = ViewConstraints.radius.rawValue
        self.calculateButton.clipsToBounds = true
        self.calculateButton.backgroundColor = .systemGray6
        self.calculateButton.frame.size.height = ViewConstraints.heightButtons.rawValue
        self.calculateButton.setTitleColor(.black, for: .normal)
        self.calculateButton.setTitle(" Рассчитать ", for: .normal)
        self.calculateButton.addTarget(self, action: #selector(self.touchedDown), for: .touchDown)
    }
    
    @objc func touchedDown() {
        var date = [String]()
        date.append(self.dateFromTextField.text ?? "")
        date.append(self.dateToTextField.text ?? "")
        self.onTouchedHandler?(date)
        self.graphView.isHidden = false
    }
    
    func setConstraints() {     
        self.menuView.translatesAutoresizingMaskIntoConstraints = false
        self.menuView.topAnchor.constraint(equalTo: self.topAnchor, constant: ViewConstraints.top.rawValue).isActive = true
        self.menuView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ViewConstraints.left.rawValue).isActive = true
        self.menuView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ViewConstraints.left.rawValue).isActive = true
        self.menuView.heightAnchor.constraint(equalToConstant: ViewConstraints.heightMenu.rawValue).isActive = true
        
        self.dateFromTextField.translatesAutoresizingMaskIntoConstraints = false
        self.dateFromTextField.topAnchor.constraint(equalTo: self.menuView.bottomAnchor, constant: ViewConstraints.marginSmall.rawValue).isActive = true
        self.dateFromTextField.leadingAnchor.constraint(equalTo: self.menuView.leadingAnchor).isActive = true
        self.dateFromTextField.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -ViewConstraints.left.rawValue).isActive = true
        
        self.dateToTextField.translatesAutoresizingMaskIntoConstraints = false
        self.dateToTextField.topAnchor.constraint(equalTo: self.menuView.bottomAnchor, constant: ViewConstraints.marginSmall.rawValue).isActive = true
        self.dateToTextField.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: ViewConstraints.left.rawValue).isActive = true
        self.dateToTextField.trailingAnchor.constraint(equalTo: self.menuView.trailingAnchor).isActive = true
        
        self.calculateButton.translatesAutoresizingMaskIntoConstraints = false
        self.calculateButton.topAnchor.constraint(equalTo: self.dateFromTextField.bottomAnchor, constant: ViewConstraints.marginSmall.rawValue).isActive = true
        self.calculateButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.graphView.translatesAutoresizingMaskIntoConstraints = false
        self.graphView.topAnchor.constraint(equalTo: self.calculateButton.bottomAnchor, constant: ViewConstraints.marginSmall.rawValue).isActive = true
        self.graphView.leadingAnchor.constraint(equalTo: self.menuView.leadingAnchor).isActive = true
        self.graphView.trailingAnchor.constraint(equalTo: self.menuView.trailingAnchor).isActive = true
        self.graphView.heightAnchor.constraint(equalToConstant: ViewConstraints.heightGraph.rawValue).isActive = true
        
        self.detailView.translatesAutoresizingMaskIntoConstraints = false
        self.detailView.topAnchor.constraint(equalTo: self.graphView.bottomAnchor, constant: ViewConstraints.marginSmall.rawValue).isActive = true
        self.detailView.leadingAnchor.constraint(equalTo: self.menuView.leadingAnchor).isActive = true
        self.detailView.trailingAnchor.constraint(equalTo: self.menuView.trailingAnchor).isActive = true
        self.detailView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -ViewConstraints.bottom.rawValue).isActive = true
    }
}
