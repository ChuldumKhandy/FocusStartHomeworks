//
//  ImageCell.swift
//  DownloadImage
//
//  Created by user on 13.12.2021.
//

import UIKit

final class ImageCell: UITableViewCell {
    static let identifier = "ItemTableViewCell"
    private let pictureImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.pictureImageView)
        self.customizeImageView()
        self.setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(data: Data?) {
        guard let data = data
        else {
            return
        }
        self.pictureImageView.image = UIImage(data: data)
        self.contentView.bringSubviewToFront(self.pictureImageView)
    }
}

private extension ImageCell {
    func customizeImageView() {
        self.pictureImageView.contentMode = .scaleAspectFit
    }
    
    func setConstraint() {
        self.pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        self.pictureImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.pictureImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.pictureImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.pictureImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
