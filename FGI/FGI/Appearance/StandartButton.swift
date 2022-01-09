//
//  StandartButton.swift
//  FGI
//
//  Created by user on 08.01.2022.
//

import UIKit

final class StandartButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = ButtonConstraint.radius.rawValue
        self.clipsToBounds = true
        self.backgroundColor = MainPallete.button
        self.frame.size.height = ButtonConstraint.height.rawValue
        self.setTitleColor(MainPallete.gray, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: FontSize.large.rawValue)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
