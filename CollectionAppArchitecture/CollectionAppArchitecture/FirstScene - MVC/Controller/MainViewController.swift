//
//  ViewController.swift
//  CollectionAppArchitecture
//
//  Created by user on 26.11.2021.
//

import UIKit

class MainViewController: UIViewController {
    var mainView: MainView?
    private var cats: PresentCatsData?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView = MainView(frame: UIScreen.main.bounds)
        if let mainView = mainView {
            self.view.addSubview(mainView)
        }
        self.cats = PresentCatsData()
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
        return cats?.getCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as? ItemCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        guard let content = cats?.getContentCell(indexPath: indexPath)
        else {
            return UICollectionViewCell()
        }
        cell.configureCell(name: content.0, iconName: content.1)
        return cell
    }
    
}

extension MainViewController: UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if let cat = cats?.getContent(indexPath: indexPath) {
            let controller = AssemblySecondScene.build(cat: cat)
            
//            let presenter = DetailPresenter()
//            presenter.cat = cats?.getContent(indexPath: indexPath)
//            let controller = DetailViewController(presenter: presenter)
            navigationController?.pushViewController(controller, animated: true)
            }
        }
}
