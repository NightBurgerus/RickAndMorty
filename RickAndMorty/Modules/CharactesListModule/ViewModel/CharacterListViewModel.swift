//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Чебупелина on 20.09.2023.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire

protocol CharacterListViewModelProtocol {
    var characters: BehaviorRelay<[Character]> { get }
    var searchString: BehaviorRelay<String> { get set }
    var searchResults: BehaviorRelay<[Character]> { get }
    var count: BehaviorRelay<Int> { get }
    func getCharacters()
}

final class CharacterListViewModel: CharacterListViewModelProtocol {
    var searchString = BehaviorRelay<String>(value: "")
    private(set) var characters = BehaviorRelay<[Character]>(value: [])
    private(set) var searchResults = BehaviorRelay<[Character]>(value: [])
    private(set) var count = BehaviorRelay<Int>(value: 0)
    private let disposeBag = DisposeBag()
    private let logger = Logger()
    private(set) var page = 1
    private(set) var pageCount = 1
    private var allCharacters = [Character]()
    
    private let repository: CharactersRepositoryProtocol
    
    init(repository: CharactersRepositoryProtocol) {
        self.repository = repository
    
        searchString
            .asObservable()
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter({
                if $0.isEmpty {
                    self.searchResults.accept(self.allCharacters)
                    self.logger.info(Set(self.allCharacters.map { $0.status } ))
                    self.logger.info(Set(self.allCharacters.map { $0.gender } ))
                    return false
                }
                return true
            })
            .subscribe(onNext: { [weak self] newSearch in
                self?.searchCharacter(newSearch)
            })
            .disposed(by: disposeBag)
    }
    
    func getCharacters() {
        Task {
            if page > pageCount { return }
            let response = await repository.getCharacters(page: page)
            switch response {
            case .success(let data):
                self.characters.accept(self.characters.value + data.results)
                self.count.accept(data.info.count)
                self.pageCount = data.info.pages
                self.page += 1
            case .failure(let error): break
            }
        }
    }
    
    private func getAllCharacters() async -> [Character] {
        await Task {
            if allCharacters.isEmpty {
                let response = await repository.getAllCharacters(count: count.value)
                switch response {
                case .success(let data):
                    return data
                case .failure(let error):
                    self.logger.error(error)
                    return []
                }
            }
            return self.allCharacters
        }.value
    }
    
    private func searchCharacter(_ search: String) {
        Task {
            self.allCharacters = await getAllCharacters()
            let results = allCharacters.filter({ $0.name.lowercased().contains(search.lowercased()) })
            logger.info(allCharacters.count, results.count)
            searchResults.accept(results)
        }
    }
    
    
}
