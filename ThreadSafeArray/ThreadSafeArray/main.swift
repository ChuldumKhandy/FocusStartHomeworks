//
//  main.swift
//  ThreadSafeArray
//
//  Created by user on 05.11.2021.
//

import Foundation

var array = SafeArray<Int>()
let queue = DispatchQueue(label: "ArrayQueue", attributes: .concurrent)

queue.async {
    for number in 0...1000 {
        array.append(number)
    }
}
queue.async {
    for number in 0...1000 {
        array.append(number)
    }
}

sleep(1)
print("количество элементов: \(array.count)")
