//
//  main.swift
//  AccountingOfCars
//
//  Created by user on 28.10.2021.
//

import Foundation

var cars = [Car]()
var interrupt = false

while !interrupt {
    print("Меню\n1. Добавление нового автомобиля\n2. Вывод списка добавленных автомобилей\n3. Вывод списка автомобилей с использованием фильтра по типу кузова автомобиля\nВыберите действие...")
    switch readLine() {
        case "1":
            cars.append(addCar())
        case "2":
            printCars(cars)
        case "3":
            printFilteredCars(cars)
        default:
            interrupt = true
            print("До свидания")
    }
}

