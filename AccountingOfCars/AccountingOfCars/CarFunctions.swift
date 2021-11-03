//
//  CarFunctions.swift
//  AccountingOfCars
//
//  Created by user on 30.10.2021.
//

import Foundation

func getCarFromConsole() -> Car {
    print("Поля обязательные к заполнению отмечены звездочкой")
    print("* Производитель: ")
    let newManufacturer = isNilOrEmptyString(readLine())
    print("* Модель: ")
    let newModel = isNilOrEmptyString(readLine())
    print("* Выберите тип кузова:")
    Body.allCases.forEach { print($0) }
    let newBody = Body(bodyNumber: readLine())
    print("Год выпуска: ")
    let newYearOfIssue = Int(isNilOrEmptyString(readLine()))
    print("Гос. номер: ")
    let newCarNumber = readLine()
    return Car(manufacturer: newManufacturer, model: newModel, body: newBody, yearOfIssue: newYearOfIssue, carNumber: newCarNumber)
}

func isNilOrEmptyString(_ rawString: String?) -> String {
    guard let validString = rawString,
          validString.isEmpty == false
    else {
        return "Вы не ввели значение"
    }
    return validString
}

func printCar(_ car: Car) {
    print("Производитель: \(car.manufacturer)")
    print("Модель: \(car.model)")
    print("Тип кузова: \(car.body.rawValue)")
    if let yaer = car.yearOfIssue {
        print("Год выпуска: \(yaer)")
    }
    else {
        print("Год выпуска: -")
    }
    if let number = car.carNumber,
       number.isEmpty == false {
        print("Гос. номер: \(number)")
    }
}

func printCars(_ arrayCar: [Car]){
    print("Список автомобилей:")
    arrayCar.forEach({printCar($0)})
}

func printFilteredCars(_ cars: [Car]) {
    print("Выберите тип кузова:")
    Body.allCases.forEach { print($0) }
    let filteredBody = Body(bodyNumber: readLine())
    let filteredCars = cars.filter({ $0.body == filteredBody })
    print("Список автомобилей по фильтру \(filteredBody.rawValue)")
    if filteredCars.isEmpty == false {
        printCars(filteredCars)
    }
    else {
        print("Ничего не найдено")
    }
}

