//
//  СarВody.swift
//  AccountingOfCars
//
//  Created by user on 30.10.2021.
//

import Foundation

enum Body: String, CustomStringConvertible, CaseIterable {
    case notValid = "Вы не ввели значение"
    case sedan = "Седан"
    case hatchback = "Хэтчбек"
    case universal = "Универсал"
    case limousine = "Лимузин"
    case pickup = "Пикап"
    
    var description: String {
        switch self {
        case .sedan:
            return "1. \(self.rawValue)"
        case .hatchback:
            return "2. \(self.rawValue)"
        case .universal:
            return "3. \(self.rawValue)"
        case .limousine:
            return "4. \(self.rawValue)"
        case .pickup:
            return "5. \(self.rawValue)"
        default:
            return "Введите соответствующий номер:"
        }
    }
    
    init(bodyNumber: String?) {
        switch bodyNumber {
        case "1":
            self = .sedan
        case "2":
            self = .hatchback
        case "3":
            self = .universal
        case "4":
            self = .limousine
        case "5":
            self = .pickup
        default:
            self = .notValid
        }
    }
    
    
//    func choiceBody(bodyNumber: String?) -> Body {
//        switch bodyNumber {
//            case "1":
//                return .sedan
//            case "2":
//                return .hatchback
//            case "3":
//                return.universal
//            case "4":
//                return .limousine
//            case "5":
//                return .pickup
//            default:
//                return .notValid
//        }
//    }
}
