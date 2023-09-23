//
//  TitleView.swift
//  RickAndMorty
//
//  Created by Чебупелина on 21.09.2023.
//

import UIKit
import RxCocoa
import RxSwift

final class TitleView: UIView {
    private var textFieldBackground = UIView()
    private var textField = UITextField()
    private var clearButton = UIButton(type: .custom)
    private var leadingConstraint: NSLayoutConstraint!
    private var leadingConstant: CGFloat = 40
    private let trailingConstant: CGFloat = -8
    private(set) var searchIsOpen = BehaviorRelay<Bool>(value: false)
    private(set) var searchText = BehaviorRelay<String>(value: "")
    
    private let logger = Logger()
    private let label = UILabel()
    private var title: String!
    private let animationDuration = 0.5
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        configureTextField()
        configureTitle()
        configureSearchImage()
        configureClearButton()
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
        searchImage.tintColor = R.Colors.appForeground
        addSubview(searchImage)
        
        searchImage.translatesAutoresizingMaskIntoConstraints = false
        let imageCenterYConstraint = NSLayoutConstraint(item: searchImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        let imageTrailingConstraint = NSLayoutConstraint(item: searchImage, attribute: .trailing, relatedBy: .equal, toItem: textFieldBackground, attribute: .leading, multiplier: 1.0, constant: -4)
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
    
    private func configureClearButton() {
        clearButton.setImage(UIImage(systemName: "xmark.circle")!, for: .normal)
        clearButton.tintColor = R.Colors.lightGray
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(clearButton)
        
        let trailingConstraint = NSLayoutConstraint(item: clearButton, attribute: .trailing, relatedBy: .equal, toItem: textFieldBackground, attribute: .trailing, multiplier: 1.0, constant: -10)
        let centerYConstraint = NSLayoutConstraint(item: clearButton, attribute: .centerY, relatedBy: .equal, toItem: textField, attribute: .centerY, multiplier: 1.0, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: clearButton, attribute: .height, relatedBy: .equal, toItem: textField, attribute: .height, multiplier: 0.6, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: clearButton, attribute: .width, relatedBy: .equal, toItem: textField, attribute: .height, multiplier: 0.6, constant: 0)
        NSLayoutConstraint.activate([
            trailingConstraint,
            centerYConstraint,
            heightConstraint,
            widthConstraint
        ])
        
        clearButton.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
        clearButton.alpha = 0
    }
    
    private func configureTextField() {
        textFieldBackground.backgroundColor = R.Colors.gray
        textField.textColor = R.Colors.appForeground
        
        textFieldBackground.layer.cornerRadius = 8
        
        addSubview(textField)
        textField.addSubview(textFieldBackground)
        textField.delegate = self
        
        textFieldBackground.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let inputLeadingConstraint = NSLayoutConstraint(item: textFieldBackground, attribute: .leading, relatedBy: .equal, toItem: textField, attribute: .leading, multiplier: 1.0, constant: -8)
        let inputTrailingConstraint = NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: textFieldBackground, attribute: .trailing, multiplier: 1.0, constant: -32)
        let heightConstraint = NSLayoutConstraint(item: textFieldBackground, attribute: .height, relatedBy: .equal, toItem: textField, attribute: .height, multiplier: 1.0, constant: textField.frame.height + 4)
        let centerYConstraint = NSLayoutConstraint(item: textField, attribute: .centerY, relatedBy: .equal, toItem: textFieldBackground, attribute: .centerY, multiplier: 1.0, constant: 0)
        
        leadingConstraint = NSLayoutConstraint(item: textFieldBackground, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: trailingConstant)
        let trailingConstraint = NSLayoutConstraint(item: textFieldBackground, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: trailingConstant)
        let topConstraint = NSLayoutConstraint(item: textFieldBackground, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 6)
        let bottomConstraint = NSLayoutConstraint(item: textFieldBackground, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -6)
        
        NSLayoutConstraint.activate([
            centerYConstraint,
            inputLeadingConstraint,
            inputTrailingConstraint,
            heightConstraint,
            leadingConstraint,
            trailingConstraint,
            topConstraint,
            bottomConstraint
        ])
    }
}

// MARK: – Delegates
extension TitleView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        searchText.accept(textField.text ?? "")
    }
}

// MARK: - Actions
extension TitleView {
    func openSearch() {
        UIView.animate(withDuration: animationDuration / 2) {
            self.label.alpha = 0
        }
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut) {
            self.clearButton.alpha = 1
            self.leadingConstraint.isActive = false
            self.leadingConstraint = NSLayoutConstraint(item: self.textFieldBackground, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: self.leadingConstant)
            self.leadingConstraint.isActive = true
            self.layoutIfNeeded()
            self.textField.becomeFirstResponder()
        }
    }
    
    func closeSearch() {
        self.textField.resignFirstResponder()
        UIView.animate(withDuration: animationDuration / 2, delay: animationDuration / 2) {
            self.label.alpha = 1
        }
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut) {
            self.clearButton.alpha = 0
            self.leadingConstraint.isActive = false
            self.leadingConstraint = NSLayoutConstraint(item: self.textFieldBackground, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: self.trailingConstant)
            self.leadingConstraint.isActive = true
            self.layoutIfNeeded()
        }
    }
    
    @objc private func clearTextField() {
        self.textField.text = ""
    }
    
    @objc private func toggleSearch() {
        if searchIsOpen.value {
            closeSearch()
        } else {
            openSearch()
        }
        searchIsOpen.accept(!searchIsOpen.value)
    }
}
