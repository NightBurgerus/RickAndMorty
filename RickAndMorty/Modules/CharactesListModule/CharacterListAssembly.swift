//
//  CharacterListAssembly.swift
//  RickAndMorty
//
//  Created by Чебупелина on 20.09.2023.
//

import UIKit

final class CharacterListAssembly: NSObject {
    @IBOutlet var viewController: UIViewController!
    override func awakeFromNib() {
        guard let view = viewController as? CharacterListViewController else { return }
        let viewModel = CharacterListViewModel()
        view.setup(viewModel: viewModel)
    }
}
