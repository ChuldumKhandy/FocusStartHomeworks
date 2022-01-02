//
//  CurrencyView.swift
//  FGI
//
//  Created by user on 25.12.2021.
//

import UIKit

final class CurrencyPikerView: UIView {
    private let currencyPikerView = UIPickerView()
    private var currencies = [String]()
    var getCurrenciesHandler: (([String]) -> Void)?
    var selectedCurrencyHandler: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(self.currencyPikerView)
        self.customizePickerView()
        self.setConstraints()
        self.getCurrenciesHandler = { [weak self] currencies in
            self?.currencies = currencies
            self?.currencyPikerView.reloadAllComponents()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrencyPikerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCurrencyHandler?(self.currencies[row])
    }
}

extension CurrencyPikerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        self.endEditing(true)
        let pickerLabel = UILabel()
        pickerLabel.text = self.currencies[row]
        pickerLabel.textAlignment = .center
        pickerLabel.textColor = .black
        pickerLabel.font = UIFont.systemFont(ofSize: FontSize.title.rawValue)
        return pickerLabel
    }
}

private extension CurrencyPikerView {
    func customizePickerView() {
        self.currencyPikerView.dataSource = self
        self.currencyPikerView.delegate = self
    }
    
    func setConstraints() {
        self.currencyPikerView.translatesAutoresizingMaskIntoConstraints = false
        self.currencyPikerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.currencyPikerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.currencyPikerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.currencyPikerView.heightAnchor.constraint(equalToConstant: ViewConstraints.heightMenu.rawValue).isActive = true
    }
}
