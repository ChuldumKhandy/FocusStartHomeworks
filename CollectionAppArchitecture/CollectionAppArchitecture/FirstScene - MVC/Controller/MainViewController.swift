//
//  ViewController.swift
//  CollectionAppArchitecture
//
//  Created by user on 26.11.2021.
//

import UIKit

final class MainViewController: UIViewController {
    private var mainView: MainView?
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
        return cats?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as? ItemCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        guard let cat = cats?[indexPath.row]
        else {
            return UICollectionViewCell()
        }
        cell.configureCell(name: cat.name, iconName: cat.iconName)
        return cell
    }
    
}

extension MainViewController: UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if let cat = cats?[indexPath.row] {
                let controller = AssemblySecondScene.build(cat: cat)
                navigationController?.pushViewController(controller, animated: true)
            }
        }
}
