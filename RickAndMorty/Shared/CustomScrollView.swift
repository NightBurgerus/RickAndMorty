//
//  CustomScrollView.swift
//  RickAndMorty
//
//  Created by Чебупелина on 23.09.2023.
//

import UIKit

final class CustomScrollView: UIScrollView {
    var previousOffset: CGPoint = .zero
    private let logger = Logger()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    private func configureView() {
        addObserver(self, forKeyPath: "contentOffset", options: .old, context: nil)
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" {
            guard let change = change?[NSKeyValueChangeKey(rawValue: "old")], let oldPoint = change as? CGPoint else { return }
            self.previousOffset = oldPoint
        }
    }
    
    deinit {
        removeObserver(self, forKeyPath: "contentOffset")
    }
}

