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
        configureCollectionView()
        self.addSubview(collectionView)
        configureCollectionViewLayout()
    }
}

private extension MainView {
    func configureCollectionView() {
        let lineSpacing: CGFloat = 10
        let interitemSpacing: CGFloat = 5
        let cellSize = self.frame.width * 0.5 - interitemSpacing
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = interitemSpacing
        layout.itemSize = CGSize(width: cellSize, height: cellSize)
        collectionView.backgroundColor = .white
        collectionView.frame = self.bounds
        collectionView.register(ItemCollectionViewCell.self,
                                forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
    }
    
    func configureCollectionViewLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
