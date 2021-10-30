//
//  CarFunctions.swift
//  AccountingOfCars
//
//  Created by user on 30.10.2021.
//

import Foundation

func addCar() -> Car {
    print("Поля обязательные к заполнению отмечены звездочкой")
    print("* Производитель: ")
    let newManufacturer = isValidString(readLine())
    print("* Модель: ")
    let newModel = isValidString(readLine())
    print("* Выберите тип кузова:\n1.Седан\n2.Хэтчбек\n3.Универсал\n4.Лимузин\n5.Пикап\nВведите соответствующий номер: ")
    let newBody = choiceBody(readLine())
    print("Год выпуска: ")
    let newYearOfIssue = Int(isValidString(readLine()))
    print("Гос. номер: ")
    let newCarNumber = readLine()
    return Car(manufacturer: newManufacturer, model: newModel, body: newBody, yearOfIssue: newYearOfIssue, carNumber: newCarNumber)
}

func isNilOrEmpty(_ str: String?) -> Bool {
    guard let myStr = str,
          !myStr.isEmpty
    else {
        return false
    }
    return true
}

func isValidString(_ rawString: String?) -> String {
    return isNilOrEmpty(rawString)
        ? rawString!
        : "Вы не ввели значение"
}

func choiceBody(_ bodyNumber: String?) -> EnumBody {
    switch bodyNumber {
        case "1":
            return .sedan
        case "2":
            return .hatchback
        case "3":
            return.universal
        case "4":
            return .limousine
        case "5":
            return .pickup
        default:
            return .notValid
    }
}

func printCar(_ car: Car) {
    print("Производитель: \(car.manufacturer)")
    print("Модель: \(car.model)")
    print("Тип кузова: \(car.body.rawValue)")
    if car.yearOfIssue != nil {
        print("Год выпуска: \(car.yearOfIssue!)")
    }
    else {
        print("Год выпуска: -")
    }
    if !isNilOrEmpty(car.carNumber) {
        print("Гос. номер: \(car.carNumber!)")
    }
}

func printCars(_ arrayCar: [Car]){
    print("Список автомобилей;")
    for car in arrayCar {
        printCar(car)
    }
}

func printFilteredCars(_ cars: [Car]) {
    print("Выберите тип кузова:\n1.Седан\n2.Хэтчбек\n3.Универсал\n4.Лимузин\n5.Пикап\nВведите соответствующий номер:")
    let filteredBody = choiceBody(readLine())
    let filteredCars = getCarsByBody(cars: cars, body: filteredBody)
    print("Список автомобилей по фильтру \(filteredBody.rawValue)")
    if filteredCars.count != 0 {
        printCars(filteredCars)
    }
    else {
        print("Ничего не найдено")
    }
}

func getCarsByBody(cars: [Car], body: EnumBody) -> [Car] {
    return cars.filter({ $0.body == body })
}

