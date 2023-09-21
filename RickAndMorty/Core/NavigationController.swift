//
//  NavigationController.swift
//  RickAndMorty
//
//  Created by Чебупелина on 21.09.2023.
//

import Foundation
import UIKit

final class NavigationController: UINavigationController {
    func setTitleViewWithSearch(onChangeText: @escaping(String) -> ()) {
        let logger = Logger()
        let titleView = TitleView(title: "Some Title", onChangeText: onChangeText)
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

//let titleView = TitleView(title: "", onChangeText: { _ in })
//navigationBar.addSubview(titleView)
//titleView.translatesAutoresizingMaskIntoConstraints = false
//NSLayoutConstraint.activate([
//    titleView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
//    titleView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),
//    titleView.topAnchor.constraint(equalTo: navigationBar.topAnchor),
//    titleView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor)
//])
//titleView.configureView()
//
//DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//    titleView.closeSearch()
//}
