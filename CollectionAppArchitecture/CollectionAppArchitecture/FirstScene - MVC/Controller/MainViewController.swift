//
//  ViewController.swift
//  CollectionAppArchitecture
//
//  Created by user on 26.11.2021.
//

import UIKit

class MainViewController: UIViewController {
    var mainView: MainView?
    private var cats: [Cat]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView = MainView(frame: UIScreen.main.bounds)
        if let mainView = mainView {
            self.view.addSubview(mainView)
        }
        self.cats = Cat.getCatsFromJson()
        self.mainView?.loadView(controller: self)
        self.mainView?.collectionView.delegate = self
        self.mainView?.collectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mainView?.configureMainView()
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cats?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as? ItemCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        guard let name = self.cats?[indexPath.row].name,
              let iconName = self.cats?[indexPath.row].iconName
        else {
            return UICollectionViewCell()
        }
        cell.configureCell(name: name, iconName: iconName)
        return cell
    }
    
}

extension MainViewController: UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let presenter = DetailPresenter()
            presenter.cat = self.cats?[indexPath.row]
            let controller = DetailViewController(presenter: presenter)
            navigationController?.pushViewController(controller, animated: true)
        }
}
