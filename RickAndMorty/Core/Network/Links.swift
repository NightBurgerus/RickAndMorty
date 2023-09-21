//
//  Links.swift
//  RickAndMorty
//
//  Created by Чебупелина on 21.09.2023.
//

import Foundation

struct Links {
    static private let base = "https://rickandmortyapi.com/api"
    
    struct Character {
        static private let charactersBase = base + "/character"
        static func get(byId id: Int) -> String {
            return charactersBase + "/\(id)"
        }
        static func page(_ page: Int) -> String {
            return charactersBase + "/?page=\(page)"
        }
    }
}
