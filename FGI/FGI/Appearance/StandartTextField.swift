//
//  StandartTextField.swift
//  FGI
//
//  Created by user on 08.01.2022.
//

import UIKit

final class StandartTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.borderStyle = .roundedRect
        self.layer.cornerRadius = TextFieldConstraint.radius.rawValue
        self.layer.masksToBounds = true
        self.frame.size.height = TextFieldConstraint.height.rawValue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
