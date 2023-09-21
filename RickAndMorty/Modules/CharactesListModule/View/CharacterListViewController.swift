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
    
    @IBOutlet weak var searchCharactersListTableView: UITableView!
    @IBOutlet weak var searchContainer: UIView!
    
    @IBOutlet weak var listContainer: UIView!
    @IBOutlet weak var charactersListTableView: UITableView!
    private var logger = Logger()
    
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
        searchCharactersListTableView.register(UINib(nibName: Constants.cellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        setupBindings()
        
        (navigationController as? NavigationController)?.setTitleViewWithSearch(onChangeText: { [weak self] searchText in
            self?.logger.debug(searchText)
        })
    }
    
    private func setupBindings() {
        // Общий список персонажей
        viewModel
            .characters
            .bind(to: charactersListTableView.rx.items(cellIdentifier: Constants.cellIdentifier, cellType: Constants.cellType)) { (_, element, cell) in
                cell.configure(character: element)
            }
            .disposed(by: disposeBag)
        
        // Результаты поиска
        viewModel
            .searchResults
            .bind(to: searchCharactersListTableView.rx.items(cellIdentifier: Constants.cellIdentifier, cellType: Constants.cellType)) { (_, element, cell) in
                cell.configure(character: element)
            }
            .disposed(by: disposeBag)
        
        charactersListTableView
            .rx
            .contentOffset
            .asObservable()
            .filter { [weak self] offset in
                guard let self = self,
                let cellHeight = self.charactersListTableView.visibleCells.randomElement()?.frame.height else { return false }
                let height = self.charactersListTableView.contentSize.height
                
                return offset.y > (height - cellHeight * 8)
            }
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in self?.viewModel.getCharacters() })
            .disposed(by: disposeBag)
    }
    
    private func loadData() {
        viewModel.getCharacters()
    }
}
