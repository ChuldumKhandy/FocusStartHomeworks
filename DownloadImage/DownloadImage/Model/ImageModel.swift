//
//  Image.swift
//  DownloadImage
//
//  Created by user on 13.12.2021.
//

import Foundation

protocol IImageModel {
    func setUrl(url: URL?)
    func getUrls() -> [URL]
}

final class ImageModel {
    private var images: [URL] = []
}

extension ImageModel: IImageModel {
    func getUrls() -> [URL] {
        return self.images
    }
    
    func setUrl(url: URL?) {
        guard let urlImage = url
        else {
            return
        }
        self.images.append(urlImage)
        self.images.forEach { (URL) in
            print("Наши УРЛЫ: \(URL)")
        }
    }
}
