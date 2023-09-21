//
//  NetworkServiceConfiguration.swift
//  RickAndMorty
//
//  Created by Чебупелина on 21.09.2023.
//

import Foundation

final class NetworkServiceConfiguration {
    typealias HTTPHeaders = [String: String]
    typealias FormData = [String: String]
    
    var headers: HTTPHeaders = [:]
    var formData: FormData = [:]
    var decoder: JSONDecoder = JSONDecoder()
}
