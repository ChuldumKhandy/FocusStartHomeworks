//
//  main.swift
//  ThreadSafeArray
//
//  Created by user on 05.11.2021.
//

import Foundation

var array = ThreadSafeArray<Int>()
let queue = DispatchQueue(label: "ArrayQueue", attributes: .concurrent)
let group =  DispatchGroup()

group.enter()
queue.async {
    for number in 0...1000 {
        array.append(number)
    }
    group.leave()
}
group.enter()
queue.async {
    for number in 0...1000 {
        array.append(number)
    }
    group.leave()
}

group.wait()
print("количество элементов: \(array.count)")
