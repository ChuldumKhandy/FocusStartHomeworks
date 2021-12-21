//
//  Assembly.swift
//  DownloadImage
//
//  Created by user on 13.12.2021.
//

import UIKit

final class Assembly {
    static func build() -> UIViewController {
        let model = ImageModel()
        let controller = MainVC()
        let presenter = MainPresenter(imageModel: model, controller: controller)
        controller.presenter = presenter
        return controller
    }
}
