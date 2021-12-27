//
//  LogInUser.swift
//  FGI
//
//  Created by user on 27.12.2021.
//

import Foundation



final class LogInUser {
    let uid: UUID
    let login: String
    let password: String
    
    init(login: String, password: String) {
        self.uid = UUID()
        self.login = login
        self.password = password
    }

    init?(user: User) {
        self.uid = user.uid
        self.login = user.login
        self.password = user.password
    }
}
