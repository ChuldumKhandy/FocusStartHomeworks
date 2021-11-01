//
//  main.swift
//  AccountingOfCars
//
//  Created by user on 28.10.2021.
//

import Foundation

var cars = [Car]()
var interruption = true

while interruption {
    print("""
Меню
1. Добавление нового автомобиля
2. Вывод списка добавленных автомобилей
3. Вывод списка автомобилей с использованием фильтра по типу кузова автомобиля
Выберите действие...
""")
    switch readLine() {
        case "1":
            cars.append(getCarFromConsole())
        case "2":
            printCars(cars)
        case "3":
            printFilteredCars(cars)
        default:
            print("До свидания")
            interruption = false
    }
}

