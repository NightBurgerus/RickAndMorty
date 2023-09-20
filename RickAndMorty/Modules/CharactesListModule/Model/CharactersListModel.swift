//
//  CharactersListModel.swift
//  RickAndMorty
//
//  Created by Чебупелина on 20.09.2023.
//

import Foundation

struct CharactersListResponse: Decodable {
    let info: CharactersListInfo
    let results: [Character]
}

struct CharactersListInfo: Decodable {
    let count: Int
    let pages: Int
    let next: URL?
    let prev: URL?
}

struct Character: Decodable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: CharacterOrigin
    let location: CharacterLocation
    let image: URL?
    let episode: [URL]
    let url: URL
    let created: String
}

struct CharacterOrigin: Decodable {
    let name: String
    let url: String
}

struct CharacterLocation: Decodable {
    let name: String
    let url: String
}
