//
//  NavigationController.swift
//  RickAndMorty
//
//  Created by Чебупелина on 21.09.2023.
//

import Foundation
import UIKit

final class NavigationController: UINavigationController {
    func setTitleViewWithSearch() {
        let textField = UITextField()
        let backgroundView = UIView()
        textField.backgroundColor = .blue
        backgroundView.addSubview(textField)
        
        backgroundView.backgroundColor = .red

        navigationBar.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        var leadingConstraint = NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: backgroundView, attribute: .leading, multiplier: 1.0, constant: 8)
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: navigationBar.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            
//            textField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: leadingConstraint),
            leadingConstraint,
            textField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -8),
            textField.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
        ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            UIView.animate(withDuration: 1) {
                leadingConstraint.isActive = false
                leadingConstraint = NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: backgroundView, attribute: .trailing, multiplier: 1.0, constant: -8)
                leadingConstraint.isActive = true
                backgroundView.layoutIfNeeded()
                textField.layoutIfNeeded()
            }
        }
    }
    
}
