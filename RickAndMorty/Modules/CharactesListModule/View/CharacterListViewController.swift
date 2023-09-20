//
//  CharacterListViewController.swift
//  RickAndMorty
//
//  Created by Чебупелина on 20.09.2023.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

private enum Constants {
    static let cellIdentifier = String(describing: CharacterCell.self)
    static let cellType = CharacterCell.self
}

final class CharacterListViewController: UIViewController {
    @IBOutlet weak var charactersListTableView: UITableView!
    
    
    private var viewModel: CharacterListViewModelProtocol!
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
    
    func setup(viewModel: CharacterListViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    private func setupUI() {
        charactersListTableView.register(UINib(nibName: Constants.cellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel
            .characters
            .bind(to: charactersListTableView.rx.items(cellIdentifier: Constants.cellIdentifier, cellType: Constants.cellType)) { (_, element, cell) in
                cell.configure(character: element)
            }
            .disposed(by: disposeBag)
    }
    
    private func loadData() {
        viewModel.getCharacters()
    }
}
