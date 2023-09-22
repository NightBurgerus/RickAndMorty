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
    
    @IBOutlet weak var charactersCountLabel: UILabel!
    @IBOutlet weak var searchCountLabel: UILabel!
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
        
        // Конфигурация поисковой строки
        guard let navController = (navigationController as? NavigationController) else { return }
        let config = TitleViewConfiguration()
        config.title = "Some Title 2"
        config.onSearchToggle = { [weak self] isOn in
            UIView.animate(withDuration: 0.5) {
                self?.listContainer.alpha = isOn ? 0 : 1
                self?.searchContainer.alpha = isOn ? 1 : 0
            }
        }
        config.onChangeText = { [weak self] searchText in
            self?.viewModel.searchString.accept(searchText)
        }
        navController.setTitleViewWithSearch(configuration: config)
    }
    
    private func setupBindings() {
        // Общий список персонажей
        viewModel
            .characters
            .bind(to: charactersListTableView.rx.items(cellIdentifier: Constants.cellIdentifier, cellType: Constants.cellType)) { (_, element, cell) in
                cell.configure(character: element)
            }
            .disposed(by: disposeBag)
        
        viewModel
            .count
            .map { "Total count: \($0)" }
            .bind(to: charactersCountLabel.rx.text)
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
        
        // Результаты поиска
        viewModel
            .searchResults
            .bind(to: searchCharactersListTableView.rx.items(cellIdentifier: Constants.cellIdentifier, cellType: Constants.cellType)) { (_, element, cell) in
                cell.configure(character: element)
            }
            .disposed(by: disposeBag)
        
        viewModel
            .searchResults
            .asObservable()
            .map({ "Search results: \($0.count)" })
            .bind(to: searchCountLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    private func loadData() {
        viewModel.getCharacters()
    }
}
