//
//  ViewController.swift
//  CollectionApp
//
//  Created by user on 17.11.2021.
//

import UIKit

class ViewController: UIViewController {
    private var collectionView: UICollectionView?
    private var itemCatArray = [Cat]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fillArray()
        configureVC()
    }
}

extension ViewController {
    func configureVC() {
        configureCollectionView()
    }
    
    func fillArray() {
        itemCatArray.append(Cat(name: "Cat and home", iconName: "Cat and home"))
        itemCatArray.append(Cat(name: "Lion cat", iconName: "Lion cat"))
        itemCatArray.append(Cat(name: "Shark cat", iconName: "Shark cat"))
        itemCatArray.append(Cat(name: "Cat chef", iconName: "Cat chef"))
        itemCatArray.append(Cat(name: "Cat and breakfast", iconName: "Cat and breakfast"))
        itemCatArray.append(Cat(name: "Cat and training", iconName: "Cat and training"))
        itemCatArray.append(Cat(name: "Cat and pizza", iconName: "Cat and pizza"))
        itemCatArray.append(Cat(name: "Cat and hide-and-seek", iconName: "Cat and hide-and-seek"))
        itemCatArray.append(Cat(name: "Cat and shrimp", iconName: "Cat and shrimp"))
        itemCatArray.append(Cat(name: "Cat and seal", iconName: "Cat and seal"))
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func configureCollectionView() {
        let lineSpacing: CGFloat = 10
        let interitemSpacing: CGFloat = 5
        let cellSize = self.view.frame.width * 0.5 - interitemSpacing
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = interitemSpacing
        layout.itemSize = CGSize(width: cellSize, height: cellSize)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.backgroundColor = .white
        collectionView.frame = view.bounds
        collectionView.register(ItemCollectionViewCell.self,
                                forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCatArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as? ItemCollectionViewCell
        else { return UICollectionViewCell() }
        
        cell.configureCell(name: itemCatArray[indexPath.row].name)
        return cell
    }
}
