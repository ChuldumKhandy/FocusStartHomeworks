//
//  ViewModelModally.swift
//  CollectionAppArchitecture
//
//  Created by user on 28.11.2021.
//

import Foundation

final class ModallyViewModel {
    private let modelModally = CatImage()
    
    var dataModally: Observable<String> = Observable<String>(data: "cat")
    
    init() {
        self.updateModel()
    }
    
    func updateModel() {
        let timeLoad = Int.random(in: 1..<5)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(timeLoad)) { [weak self] in
            self?.modelModally.set(catImageName: "cat2")
            DispatchQueue.main.async { [weak self] in
                if let data = self?.modelModally.getData() {
                    self?.dataModally.data = data
                }
            }
        }
    }
}

final class Observable<T> {
    var data: T {
        didSet {
            self.notify?(self.data)
        }
    }
    
    private var notify: ((T) -> Void)?
    
    init(data: T) {
        self.data = data
    }
    
    func setNotify(notify: ((T) -> Void)?) {
        self.notify = notify
        self.notify?(self.data)
    }
}



