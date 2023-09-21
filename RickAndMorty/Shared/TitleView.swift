//
//  TitleView.swift
//  RickAndMorty
//
//  Created by Чебупелина on 21.09.2023.
//

import UIKit

final class TitleView: UIView {
    private var onChangeText: (String) -> ()
    private var title: String
    private var animationDuration = 1.0
    private var textField = UITextField()
    private var leadingConstraint: NSLayoutConstraint!
    private var leadingConstant: CGFloat = 40
    private let trailingConstant: CGFloat = -16
    private var searchIsOpen = false
    
    private let label = UILabel()
    
    init(title: String, animationDuration: Double = 0.5, onChangeText: @escaping (String) -> ()) {
        self.title = title
        self.animationDuration = animationDuration
        self.onChangeText = onChangeText
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        
        configureTextField()
        configureTitle()
        configureSearchImage()
    }
    
    private func configureTitle() {
        label.text = title
        label.font = .systemFont(ofSize: 22, weight: .bold)
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func configureSearchImage() {
        let searchImage = UIImageView(image: UIImage(systemName: "magnifyingglass")!)
        addSubview(searchImage)
        
        searchImage.translatesAutoresizingMaskIntoConstraints = false
        let imageCenterYConstraint = NSLayoutConstraint(item: searchImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        let imageTrailingConstraint = NSLayoutConstraint(item: searchImage, attribute: .trailing, relatedBy: .equal, toItem: textField, attribute: .leading, multiplier: 1.0, constant: -4)
        let imageHeightConstraint = NSLayoutConstraint(item: searchImage, attribute: .height, relatedBy: .equal, toItem: textField, attribute: .height, multiplier: 1.0, constant: 0)
        let imageWidthConstraint = NSLayoutConstraint(item: searchImage, attribute: .width, relatedBy: .equal, toItem: searchImage, attribute: .height, multiplier: 1.0, constant: 0)
        NSLayoutConstraint.activate([
            imageCenterYConstraint,
            imageTrailingConstraint,
            imageHeightConstraint,
            imageWidthConstraint
        ])
        
        searchImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSearch))
        searchImage.addGestureRecognizer(tapGesture)
    }
    
    @objc private func toggleSearch() {
        if searchIsOpen {
            closeSearch()
        } else {
            openSearch()
        }
        searchIsOpen.toggle()
    }
    
    private func configureTextField() {
        addSubview(textField)
        textField.delegate = self
          
        textField.backgroundColor = .gray.withAlphaComponent(0.7)
        textField.textColor = .white
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 2
        
        textField.delegate = self

        textField.translatesAutoresizingMaskIntoConstraints = false
        leadingConstraint = NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: trailingConstant)
        let trailingConstraint = NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: trailingConstant)
        let topConstraint = NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 8)
        let bottomConstraint = NSLayoutConstraint(item: textField, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -8)
        
        NSLayoutConstraint.activate([
            leadingConstraint,
            trailingConstraint,
            topConstraint,
            bottomConstraint
        ])
    }
    
    func openSearch() {
        UIView.animate(withDuration: animationDuration / 2) {
            self.label.alpha = 0
        }
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut) {
            self.leadingConstraint.isActive = false
            self.leadingConstraint = NSLayoutConstraint(item: self.textField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: self.leadingConstant)
            self.leadingConstraint.isActive = true
            self.layoutIfNeeded()
            self.textField.becomeFirstResponder()
        }
    }
    
    func closeSearch() {
        UIView.animate(withDuration: animationDuration / 2, delay: animationDuration / 2) {
            self.label.alpha = 1
        }
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut) {
            self.leadingConstraint.isActive = false
            self.leadingConstraint = NSLayoutConstraint(item: self.textField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: self.trailingConstant)
            self.leadingConstraint.isActive = true
            self.layoutIfNeeded()
        }
    }
}

extension TitleView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.onChangeText(textField.text ?? "")
    }
}
