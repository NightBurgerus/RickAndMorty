//
//  LoadingError.swift
//  RickAndMorty
//
//  Created by Чебупелина on 21.09.2023.
//

import Foundation

enum LoadingError: Int, Error {
    case invalidURL
    case decodeError
    case requestTimeOut
    case lostConnection
    case notFound = 404
    case forbidden = 403
    case unauthorized = 401
    case badRequest = 400
    case methodNotAllowed = 405
    case serverError = 500
}
