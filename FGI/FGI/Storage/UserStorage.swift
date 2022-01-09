//
//  UserStorage.swift
//  FGI
//
//  Created by user on 08.01.2022.
//

import Foundation

protocol IUserStorage {
    func saveUser(user: SettingUser)
    func checkPassword(passoword: String) -> Bool
    func getName() -> String
}

enum SettingsKeys: String {
    case userName
    case userPassword
    case userPasswordState
}

final class UserStorage {
    private let defaults = UserDefaults.standard
}

extension UserStorage: IUserStorage {
    func saveUser(user: SettingUser) {
        defaults.set(user.name, forKey: SettingsKeys.userName.rawValue)
        defaults.set(user.password, forKey: SettingsKeys.userPassword.rawValue)
        defaults.set(user.passwordState, forKey: SettingsKeys.userPasswordState.rawValue)
    }
    
    func getName() -> String {
        return defaults.string(forKey: SettingsKeys.userName.rawValue) ?? ""
    }
    
    func checkPassword(passoword: String) -> Bool {
        guard defaults.string(forKey: SettingsKeys.userPassword.rawValue) == passoword else {
            return false
        }
        return true
    }
}
