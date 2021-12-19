//
//  FirstView.swift
//  CollectionAppArchitecture
//
//  Created by user on 26.11.2021.
//

import UIKit

final class MainView: UIView {
    private let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private weak var controller: MainViewController?

    func loadView(controller: MainViewController) {
        self.controller = controller
    }
    
    func configureMainView() {
        self.configureCollectionView()
        self.addSubview(collectionView)
        self.configureCollectionViewLayout()
    }
}

private extension MainView {
    func configureCollectionView() {
        let lineSpacing: CGFloat = 10
        let interitemSpacing: CGFloat = 5
        let cellSize = self.frame.width * 0.5 - interitemSpacing
        self.layout.scrollDirection = .vertical
        self.layout.minimumLineSpacing = lineSpacing
        self.layout.minimumInteritemSpacing = interitemSpacing
        self.layout.itemSize = CGSize(width: cellSize, height: cellSize)
        self.collectionView.backgroundColor = .white
        self.collectionView.frame = self.bounds
        self.collectionView.register(ItemCollectionViewCell.self,
                                forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
    }
    
    func configureCollectionViewLayout() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
