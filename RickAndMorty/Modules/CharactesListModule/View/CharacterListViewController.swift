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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    func setup(viewModel: CharacterListViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    private func setupUI() {
        charactersListTableView.register(UINib(nibName: Constants.cellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        searchCharactersListTableView.register(UINib(nibName: Constants.cellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        setupBindings()
        
    }
    
    private func setupNavigationBar() {
        // Конфигурация поисковой строки
        guard let navController = (navigationController as? NavigationController) else { return }

        navController.setTitleViewWithSearch(title: R.Strings.Characters.title)
        
        navController
            .titleView?
            .searchIsOpen
            .subscribe(onNext: { [weak self] isOn in
                UIView.animate(withDuration: 0.5) {
                    self?.listContainer.alpha = isOn ? 0 : 1
                    self?.searchContainer.alpha = isOn ? 1 : 0
                }
            })
            .disposed(by: disposeBag)
        
        navController
            .titleView?
            .searchText
            .subscribe(onNext: { [weak self] searchText in
                self?.viewModel.searchString.accept(searchText)
            })
            .disposed(by: disposeBag)
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
            .map { "\(R.Strings.Characters.totalCount): \($0)" }
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
            .map({ "\(R.Strings.Characters.status): \($0.count)" })
            .bind(to: searchCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        charactersListTableView
            .rx
            .itemSelected
            .asObservable()
            .subscribe(onNext: { [weak self] index in
                guard let character = self?.viewModel.characters.value[index.row] else { return }
                self?.goToCharacter(character: character)
                self?.charactersListTableView.deselectRow(at: index, animated: true)
            })
            .disposed(by: disposeBag)
        searchCharactersListTableView
            .rx
            .itemSelected
            .asObservable()
            .subscribe(onNext: { [weak self] index in
                guard let character = self?.viewModel.searchResults.value[index.row] else { return }
                self?.goToCharacter(character: character)
                self?.searchCharactersListTableView.deselectRow(at: index, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func loadData() {
        viewModel.getCharacters()
    }
    
    private func goToCharacter(character: Character) {
        guard let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "CharacterViewController") as? CharacterViewController else { return }
        vc.setup(character: character)
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
