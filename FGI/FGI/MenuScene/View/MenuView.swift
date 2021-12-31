//
//  MenuView.swift
//  FGI
//
//  Created by user on 30.12.2021.
//

import UIKit

protocol IMenuView: UIView {
    var onTouchedHandler: ((_ dateFrom: String?, _ dateTo: String?) -> Void)? { get set }
    func passCurrencies(currencies: [String])
    func getSelectedCurrency() -> String?
}

final class MenuView: UIView {
    private let currencyLabel = UILabel()
    private let dateLabel = UILabel()
    private let calculateButton = UIButton()
    private let dateFromPicker = UIDatePicker()
    private let dateToPicker = UIDatePicker()
    private let menuView = DropDownMenuView()
    
    var onTouchedHandler: ((_ dateFrom: String?, _ dateTo: String?) -> Void)?
    
    private var selectedCurrency: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.customizeView()
        self.menuView.selectedCurrencyHandler = { [weak self] selectedCurrency in
            self?.selectedCurrency = selectedCurrency
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuView: IMenuView {
    func passCurrencies(currencies: [String]) {
        self.menuView.getCurrenciesHandler?(currencies)
    }
    func getSelectedCurrency() -> String? {
        return self.selectedCurrency
    }
}

private extension MenuView {
    func addSubviews() {
        self.addSubview(self.menuView)
        self.addSubview(self.currencyLabel)
        self.addSubview(self.dateLabel)
        self.addSubview(self.calculateButton)
        self.addSubview(self.dateFromPicker)
        self.addSubview(self.dateToPicker)
    }
    
    func customizeView() {
        self.addSubviews()
        self.customizeLabels(label: self.currencyLabel, title: "Валюта:")
        self.customizeLabels(label: self.dateLabel, title: "Период:")
        self.customizeButton()
        self.setConstraints()
    }
    
    func customizeLabels(label: UILabel, title: String) {
        label.font = .systemFont(ofSize: FontSize.title.rawValue)
        label.textAlignment = .center
        label.textColor = .black
        label.text = title
    }
    
    func customizeDatePickers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapDone))
        self.addGestureRecognizer(tapGesture)
        let startDate = Calendar.current.date(from: DateComponents(year: 2021, month: 1, day: 1))
        let endDate = Calendar.current.date(from: DateComponents(year: 2021, month: 12, day: 28))
        
        UIPickerView.appearance().backgroundColor = .systemGray6
        guard let localeID = Locale.preferredLanguages.first else {
            return }
        self.dateFromPicker.locale = Locale(identifier: localeID)
        self.dateFromPicker.datePickerMode = UIDatePicker.Mode.date
        self.dateFromPicker.preferredDatePickerStyle = .compact
        self.dateFromPicker.minimumDate = startDate
        self.dateFromPicker.maximumDate = endDate
        self.dateToPicker.minimumDate = startDate
        self.dateToPicker.maximumDate = endDate
        self.dateFromPicker.setDate(startDate ?? Date(), animated: true)
        self.dateToPicker.setDate(endDate ?? Date(), animated: true)
    }
    
    @objc func tapDone() {
        self.endEditing(true)
    }
      
    func customizeButton() {
        self.calculateButton.layer.cornerRadius = ViewConstraints.radius.rawValue
        self.calculateButton.clipsToBounds = true
        self.calculateButton.backgroundColor = .systemGray6
        self.calculateButton.frame.size.height = ViewConstraints.heightButtons.rawValue
        self.calculateButton.setTitleColor(.black, for: .normal)
        self.calculateButton.setTitle(" Показать ", for: .normal)
        self.calculateButton.addTarget(self, action: #selector(self.touchedDown), for: .touchDown)
    }
    
    @objc func touchedDown() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        self.onTouchedHandler?(formatter.string(from: self.dateFromPicker.date),
                               formatter.string(from: self.dateToPicker.date))
    }
    
    func setConstraints() {
        self.currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.currencyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ViewConstraints.left.rawValue).isActive = true
        self.currencyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ViewConstraints.left.rawValue).isActive = true
        self.currencyLabel.bottomAnchor.constraint(equalTo: self.menuView.topAnchor, constant: ViewConstraints.marginSmall.rawValue).isActive = true
        
        self.menuView.translatesAutoresizingMaskIntoConstraints = false
        self.menuView.bottomAnchor.constraint(equalTo: self.dateLabel.topAnchor, constant: -ViewConstraints.marginSmall.rawValue).isActive = true
        self.menuView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ViewConstraints.left.rawValue).isActive = true
        self.menuView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ViewConstraints.left.rawValue).isActive = true
        self.menuView.heightAnchor.constraint(equalToConstant: ViewConstraints.heightMenu.rawValue).isActive = true
        
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.dateLabel.leadingAnchor.constraint(equalTo: self.menuView.leadingAnchor).isActive = true
        self.dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ViewConstraints.left.rawValue).isActive = true
        
        self.dateFromPicker.translatesAutoresizingMaskIntoConstraints = false
        self.dateFromPicker.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: ViewConstraints.marginSmall.rawValue).isActive = true
        self.dateFromPicker.leadingAnchor.constraint(equalTo: self.menuView.leadingAnchor).isActive = true
        self.dateFromPicker.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -ViewConstraints.left.rawValue).isActive = true
        
        self.dateToPicker.translatesAutoresizingMaskIntoConstraints = false
        self.dateToPicker.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: ViewConstraints.marginSmall.rawValue).isActive = true
        self.dateToPicker.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: ViewConstraints.left.rawValue).isActive = true
        self.dateToPicker.trailingAnchor.constraint(equalTo: self.menuView.trailingAnchor).isActive = true
        
        self.calculateButton.translatesAutoresizingMaskIntoConstraints = false
        self.calculateButton.topAnchor.constraint(equalTo: self.dateFromPicker.bottomAnchor, constant: ViewConstraints.marginSmall.rawValue).isActive = true
        self.calculateButton.leadingAnchor.constraint(equalTo: self.menuView.leadingAnchor).isActive = true
        self.calculateButton.trailingAnchor.constraint(equalTo: self.menuView.trailingAnchor).isActive = true
    }
}

