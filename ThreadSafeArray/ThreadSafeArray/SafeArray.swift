//
//  SafeArray.swift
//  ThreadSafeArray
//
//  Created by user on 05.11.2021.
//

import Foundation

class SafeArray <Element> {
    var array: [Element] = []
    let arrayQueue = DispatchQueue(label: "ThreadSafeArrayQueue", attributes: .concurrent)
    
    var count: Int {
        var result = 0
        arrayQueue.sync {
            result = self.array.count
        }
        return result
    }
    
    var isEmpty: Bool {
        var result = false
        arrayQueue.sync {
            result = self.array.isEmpty
        }
        return result
    }
    
    func append( _ item: Element) {
        arrayQueue.async(flags: .barrier) {
            self.array.append(item)
        }
    }
    
    func remove(at index: Int) {
        arrayQueue.async(flags: .barrier) {
            self.array.remove(at: index)
        }
    }
    
    subscript(index: Int) -> Element? {
        get {
            var element: Element!
            arrayQueue.sync {
                element = self.array[index]
            }
            return element
        }
    }
}

extension SafeArray where Element: Equatable {

    func contains(_ element: Element) -> Bool {
        var result = false
        arrayQueue.sync {
            result = self.array.contains(element)
        }
        return result
    }
}
