//
//  Response.swift
//  RickAndMorty
//
//  Created by Чебупелина on 21.09.2023.
//

import Foundation

enum LoadingResponse {
    case success(Data)
    case failure(LoadingError)
}

enum Response<T> {
    case success(T)
    case failure(LoadingError)
}
