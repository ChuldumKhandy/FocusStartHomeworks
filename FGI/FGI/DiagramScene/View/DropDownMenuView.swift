//
//  CurrencyView.swift
//  FGI
//
//  Created by user on 25.12.2021.
//

import UIKit

final class DropDownMenuView: UIView {
    //private let currencyTextField = UITextField()
    private let currencyPikerView = UIPickerView()
    var getCurrenciesHandler: (() -> [String])?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        //self.addSubview(self.currencyTextField)
        self.addSubview(self.currencyPikerView)
        //self.customizeTextField()
        self.customizePickerView()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DropDownMenuView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //self.currencyTextField.text = self.setCurrencies()[row]
        //self.currencyPikerView.isHidden = true
        
        self.currencyPikerView.reloadAllComponents()
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

//extension DropDownMenuView: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField == self.currencyTextField {
//            self.currencyPikerView.isHidden = false
//            textField.endEditing(true)
//        }
//    }
//}

private extension DropDownMenuView {
    func setCurrencies() -> [String] {
        guard let currencies = getCurrenciesHandler?() else {
            return ["Что-то пошло не так"] }
        return currencies
    }
    
//    func customizeTextField() {
//        self.currencyTextField.placeholder = "Выберите валюту"
//        self.currencyTextField.backgroundColor = .systemGray6
//        self.currencyTextField.borderStyle = .roundedRect
//        self.currencyTextField.layer.cornerRadius = 8
//        self.currencyTextField.layer.masksToBounds = true
//        self.currencyTextField.delegate = self
//    }
    
    func customizePickerView() {
        self.currencyPikerView.dataSource = self
        self.currencyPikerView.delegate = self
    }
    
    func setConstraints() {
//        self.currencyTextField.translatesAutoresizingMaskIntoConstraints = false
//        self.currencyTextField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        self.currencyTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        self.currencyTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        self.currencyTextField.heightAnchor.constraint(equalToConstant: ViewConstraints.margin.rawValue).isActive = true
        
        self.currencyPikerView.translatesAutoresizingMaskIntoConstraints = false
        self.currencyPikerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.currencyPikerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.currencyPikerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        //self.currencyPikerView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
}
