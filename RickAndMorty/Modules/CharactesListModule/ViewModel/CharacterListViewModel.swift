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
    
    private let repository: CharactersRepositoryProtocol
    
    init(repository: CharactersRepositoryProtocol) {
        self.repository = repository
    
        searchString
            .asObservable()
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter({ !$0.isEmpty })
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
    
    func searchCharacter(_ search: String) {
        logger.info(search, tag: 1)
    }
    
    
}
