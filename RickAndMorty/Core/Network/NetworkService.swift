//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by Чебупелина on 21.09.2023.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func get<T : Decodable>(url: String, decode: T.Type) async -> Response<T>
}

final class NetworkService: NetworkServiceProtocol {
    private var decoder: JSONDecoder
    private var configuration: NetworkServiceConfiguration? = nil
    
    init() {
        self.decoder = JSONDecoder()
    }
    
    init(configuration: NetworkServiceConfiguration) {
        self.decoder = configuration.decoder
        self.configuration = configuration
    }
    
    func get<T: Decodable>(url: String, decode type: T.Type) async -> Response<T> {
        guard let url = URL(string: url) else { return .failure(.invalidURL) }
        var request = URLRequest(url: url)
        let (data, response): (Data?, URLResponse?)
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            return .failure(.unknownError)
        }
        
        guard let data = data else { return .failure(.dataIsNil) }
        
        let result: T
        do {
            result = try decoder.decode(type, from: data)
        } catch {
            return .failure(.decodeError)
        }
        return .success(result)
    }
}
