//
//  Resources.swift
//  RickAndMorty
//
//  Created by Чебупелина on 20.09.2023.
//

import UIKit

private enum Tables: String {
    case characters = "CharactersLocalization"
    case genders = "GendersLocalization"
    case status = "StatusLocalization"
}

struct R {
    struct Images {
        static let noImage = UIImage(named: "no-image-rick")!
    }
    
    struct Strings {
        struct Characters {
            private static let tableName = Tables.characters.rawValue
            static let title = NSLocalizedString("list-title", tableName: tableName, bundle: .main, comment: "")
            static let status = NSLocalizedString("character-status", tableName: tableName, comment: "")
            static let gender = NSLocalizedString("character-gender", tableName: tableName, comment: "")
            static let location = NSLocalizedString("character-location", tableName: tableName, comment: "")
            static let totalCount = NSLocalizedString("characters-count", tableName: tableName, comment: "")
            static let searchCount = NSLocalizedString("search-count", tableName: tableName, comment: "")
            
            static let species = NSLocalizedString("character-species", tableName: tableName, comment: "")
            static let type = NSLocalizedString("character-type", tableName: tableName, comment: "")
            static let origin = NSLocalizedString("character-origin", tableName: tableName, comment: "")
            static let created = NSLocalizedString("character-created", tableName: tableName, comment: "")
            static let episodes = NSLocalizedString("character-episodes", tableName: tableName, comment: "")
        }
        
        struct Genders {
            private static let tableName = Tables.genders.rawValue
            static let unknown = NSLocalizedString("unknown", tableName: tableName, comment: "")
            static let female = NSLocalizedString("female", tableName: tableName, comment: "")
            static let genderless = NSLocalizedString("genderless", tableName: tableName, comment: "")
            static let male = NSLocalizedString("male", tableName: tableName, comment: "")
        }
        
        struct Status {
            private static let tableName = Tables.status.rawValue
            static let unknown = NSLocalizedString("unknown", tableName: tableName, comment: "")
            static let alive = NSLocalizedString("alive", tableName: tableName, comment: "")
            static let dead = NSLocalizedString("dead", tableName: tableName, comment: "")
        }
    }
}
