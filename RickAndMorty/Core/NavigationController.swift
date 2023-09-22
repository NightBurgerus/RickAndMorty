//
//  NavigationController.swift
//  RickAndMorty
//
//  Created by Чебупелина on 21.09.2023.
//

import Foundation
import UIKit


final class NavigationController: UINavigationController {
    var titleView: TitleView?
    var titleLabel: UILabel?
    
    func setTitle(_ title: String) {
        titleView?.alpha = 0
        if titleLabel == nil {
            titleLabel = UILabel()
            navigationBar.addSubview(titleLabel!)
            titleLabel!.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleLabel!.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
                titleLabel!.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor)
            ])
        }
        titleLabel!.alpha = 1
        titleLabel?.text = title
    }

    func setTitleViewWithSearch(configuration: TitleViewConfiguration = .default) {
        titleLabel?.alpha = 0
        if titleView == nil {
            titleView = TitleView(configuration: configuration)
            navigationBar.addSubview(titleView!)
        }
        
        titleView?.alpha = 1
        
        titleView!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleView!.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
            titleView!.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),
            titleView!.topAnchor.constraint(equalTo: navigationBar.topAnchor),
            titleView!.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor)
        ])
        titleView!.configureView()
    }
    
}
