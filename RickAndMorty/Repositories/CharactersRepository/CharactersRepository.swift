//
//  CharactersRepository.swift
//  RickAndMorty
//
//  Created by Чебупелина on 21.09.2023.
//

import Foundation

protocol CharactersRepositoryProtocol {
    func getCharacters(page: Int) async -> Response<CharactersListResponse>
    func getAllCharacters(count: Int) async -> Response<CharactersListResponse>
}

class CharactersRepository: CharactersRepositoryProtocol {
    private let service: NetworkServiceProtocol
    private let logger = Logger()
    
    init(service: NetworkServiceProtocol) {
        self.service = service
    }
    
    func getCharacters(page: Int) async -> Response<CharactersListResponse> {
        await Task {
            return await service.get(url: Links.Character.page(page), decode: CharactersListResponse.self)
        }.value
    }
    
    func getAllCharacters(count: Int) async -> Response<CharactersListResponse> {
        await Task {
            return await service.get(url: Links.Character.all(count: count), decode: CharactersListResponse.self)
        }.value
    }
}
