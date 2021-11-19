//
//  ViewController.swift
//  CollectionApp
//
//  Created by user on 17.11.2021.
//

import UIKit

class ViewController: UIViewController {
    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private var itemCatArray: itemCat?

    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
        configureVC()
    }
}

extension ViewController {
    func configureVC() {
        configureCollectionView()
        view.addSubview(collectionView)
        configureCollectionViewLayout()
    }
    
    func parseJSON() {
        guard let path = Bundle.main.path(forResource: "Cat", ofType: "json")
        else {
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            let jsonData = try Data(contentsOf: url)
            itemCatArray = try JSONDecoder().decode(itemCat.self, from: jsonData)
        } catch {
            print("Error: \(error)")
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func configureCollectionView() {
        let lineSpacing: CGFloat = 10
        let interitemSpacing: CGFloat = 5
        let cellSize = self.view.frame.width * 0.5 - interitemSpacing
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = interitemSpacing
        layout.itemSize = CGSize(width: cellSize, height: cellSize)
        collectionView.backgroundColor = .white
        collectionView.frame = view.bounds
        collectionView.register(ItemCollectionViewCell.self,
                                forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func configureCollectionViewLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCatArray?.Cat.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as? ItemCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        guard let name = itemCatArray?.Cat[indexPath.row].name,
              let iconName = itemCatArray?.Cat[indexPath.row].iconName
        else {
            return UICollectionViewCell()
        }
        cell.configureCell(name: name, iconName: iconName)
        return cell
    }
    
//    func didTapCell(cell: UICollectionViewCell, controller: UIViewController) {
//        navigationController?.pushViewController(DetailViewController(), animated: true)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DetailViewController()
        controller.detailCat = self.itemCatArray?.Cat[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}
