//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by Чебупелина on 21.09.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func get(url: String) async throws -> LoadingResponse
}

final class NetworkService: NetworkServiceProtocol {
    func get(url: String) async throws -> LoadingResponse {
        
    }
}
