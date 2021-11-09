//
//  SafeArray.swift
//  ThreadSafeArray
//
//  Created by user on 05.11.2021.
//

import Foundation

public class ThreadSafeArray <Element> {
    private var array: [Element] = []
    private let arrayQueue = DispatchQueue(label: "ThreadSafeArrayQueue", attributes: .concurrent)
    
    public var count: Int {
        var result = 0
        arrayQueue.sync {
            result = self.array.count
        }
        return result
    }
    
    public var isEmpty: Bool {
        var result = false
        arrayQueue.sync {
            result = self.array.isEmpty
        }
        return result
    }
    
    public func append( _ item: Element) {
        arrayQueue.async(flags: .barrier) {
            self.array.append(item)
        }
    }
    
    public func remove(at index: Int) {
        arrayQueue.async(flags: .barrier) {
            if index >= 0 && index < self.array.count {
                self.array.remove(at: index)
            }
        }
    }
    
    public subscript(index: Int) -> Element {
        get {
            var element: Element!
            arrayQueue.sync {
                element = self.array[index]
            }
            return element
        }
    }
}

public extension ThreadSafeArray where Element: Equatable {

    func contains(_ element: Element) -> Bool {
        var result = false
        arrayQueue.sync {
            result = self.array.contains(element)
        }
        return result
    }
}
