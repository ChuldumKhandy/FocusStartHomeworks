//
//  ModallyViewController.swift
//  CollectionAppArchitecture
//
//  Created by user on 26.11.2021.
//

import UIKit

final class ModallyViewController: UIViewController {
    private var modallyView: ModallyView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modallyView = ModallyView(frame: UIScreen.main.bounds)
        if let modallyView = self.modallyView {
            self.view.addSubview(modallyView)
        }
        
        self.modallyView?.onTouchedHandler = { [weak self] in
            self?.onTouched()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func onTouched() {
        self.dismiss(animated: true, completion: nil)
    }
}
