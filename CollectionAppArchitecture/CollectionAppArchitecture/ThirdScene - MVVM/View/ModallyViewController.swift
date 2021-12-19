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
        self.modallyView?.onTouchedUrlInstHandler = { [weak self] in
            self?.followingLink(url: "https://www.instagram.com/mofu_sand/")
        }
        self.modallyView?.onTouchedUrlTwitHandler = { [weak self] in
            self?.followingLink(url: "https://twitter.com/mofu_sand")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

private extension ModallyViewController {
    func onTouched() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func followingLink(url: String) {
        if let url = URL(string: url) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
}
