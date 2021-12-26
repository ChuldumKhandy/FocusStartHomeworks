//
//  CurrencyView.swift
//  FGI
//
//  Created by user on 25.12.2021.
//

import UIKit

final class DropDownMenuView: UIView {
    private let currencyPikerView = UIPickerView()
    var getCurrenciesHandler: (() -> [String])?
    var selectedCurrencyHandler: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(self.currencyPikerView)
        self.customizePickerView()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DropDownMenuView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCurrencyHandler?(self.setCurrencies()[row])
    }
}

extension DropDownMenuView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.setCurrencies().count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        self.endEditing(true)
        let pickerLabel = UILabel()
        pickerLabel.text = self.setCurrencies()[row]
        pickerLabel.textAlignment = .center
        pickerLabel.textColor = .black
        pickerLabel.font = UIFont(name: "Inter", size: 10)
        return pickerLabel
    }
}

private extension DropDownMenuView {
    func setCurrencies() -> [String] {
        guard let currencies = getCurrenciesHandler?() else {
            return ["Что-то пошло не так"] }
        return currencies
    }
   
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
