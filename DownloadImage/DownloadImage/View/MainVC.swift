//
//  ViewController.swift
//  DownloadImage
//
//  Created by user on 13.12.2021.
//

import UIKit

protocol IMainVC: AnyObject {
    func showAlert()
    func canOpenURL(_ string: String?) -> Bool
}

final class MainVC: UIViewController {
    private let viewScene: IMainView
    var presenter: IMainPresenter?
    
    init() {
        self.viewScene = MainView(frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.presenter?.loadView(view: self.viewScene)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.addSubview(self.viewScene)
    }
}

extension MainVC: IMainVC {
    func showAlert() {
        let alert = UIAlertController(title: "Неверный URL", message: "Проверьте правильность URL", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Понятно", style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    func canOpenURL(_ string: String?) -> Bool {
        guard let urlString = string,
            let url = URL(string: urlString)
            else { return false }

        if !UIApplication.shared.canOpenURL(url) { return false }

        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
}
