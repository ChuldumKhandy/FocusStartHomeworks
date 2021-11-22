//
//  ViewController.swift
//  CollectionApp
//
//  Created by user on 17.11.2021.
//

import UIKit

final class MainViewController: UIViewController {
    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private var catsArray: CatsArray?

    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
        configureVC()
    }
}

private extension MainViewController {
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
            catsArray = try JSONDecoder().decode(CatsArray.self, from: jsonData)
        } catch {
            print("Error: \(error)")
        }
    }
    
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
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DetailViewController()
        controller.detailCat = self.catsArray?.cat[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catsArray?.cat.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as? ItemCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        guard let name = catsArray?.cat[indexPath.row].name,
              let iconName = catsArray?.cat[indexPath.row].iconName
        else {
            return UICollectionViewCell()
        }
        cell.configureCell(name: name, iconName: iconName)
        return cell
    }
}
