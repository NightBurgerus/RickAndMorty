//
//  NavigationController.swift
//  RickAndMorty
//
//  Created by Чебупелина on 21.09.2023.
//

import Foundation
import UIKit


final class NavigationController: UINavigationController {

    func setTitleViewWithSearch(configuration: TitleViewConfiguration = .default) {
        let titleView = TitleView(configuration: configuration)
        navigationBar.addSubview(titleView)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),
            titleView.topAnchor.constraint(equalTo: navigationBar.topAnchor),
            titleView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor)
        ])
        titleView.configureView()
    }
    
}
