//
//  InfoSceneAssembly.swift
//  FGI
//
//  Created by user on 23.12.2021.
//

import UIKit

final class InfoSceneAssembly {
    static func build() -> UIViewController {
        let presenter = InfoPresenter()
        let controller = InfoVC(presenter: presenter)
        return controller
    }
}
