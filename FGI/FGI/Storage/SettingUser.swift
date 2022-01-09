//
//  SettingUser.swift
//  FGI
//
//  Created by user on 08.01.2022.
//

import Foundation

final class SettingUser {
    let name: String
    let password: String
    let passwordState: Bool
    
    init(name: String, password: String, passwordState: Bool) {
        self.name = name
        self.password = password
        self.passwordState = passwordState
    }
}
