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
    case species = "SpeciesLocalization"
}

struct R {
    private init() {}
    struct Colors {
        private init() {}
        static let appBackground = UIColor(named: "appBackground")!
        static let appForeground = UIColor(named: "appForeground")!
        static let gray = UIColor(named: "gray")!
        static let lightGray = UIColor(named: "lightGray")
    }
    struct Images {
        private init() {}
        static let noImage = UIImage(named: "no-image-rick")!
    }
    
    struct Strings {
        private init() {}
        struct Characters {
            private init() {}
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
            private init() {}
            private static let tableName = Tables.genders.rawValue
            static let unknown = NSLocalizedString("unknown", tableName: tableName, comment: "")
            static let female = NSLocalizedString("female", tableName: tableName, comment: "")
            static let genderless = NSLocalizedString("genderless", tableName: tableName, comment: "")
            static let male = NSLocalizedString("male", tableName: tableName, comment: "")
        }
        
        struct Status {
            private init() {}
            private static let tableName = Tables.status.rawValue
            static let unknown = NSLocalizedString("unknown", tableName: tableName, comment: "")
            static let alive = NSLocalizedString("alive", tableName: tableName, comment: "")
            static let dead = NSLocalizedString("dead", tableName: tableName, comment: "")
        }
        struct Species {
            private init() {}
            private static let tableName = Tables.species.rawValue
            static let human = NSLocalizedString("human", tableName: tableName, comment: "")
            static let cronenberg = NSLocalizedString("cronenberg", tableName: tableName, comment: "")
            static let humanoid = NSLocalizedString("humanoid", tableName: tableName, comment: "")
            static let animal = NSLocalizedString("animal", tableName: tableName, comment: "")
            static let disease = NSLocalizedString("disease", tableName: tableName, comment: "")
            static let mythologicalCreature = NSLocalizedString("mythological-creature", tableName: tableName, comment: "")
            static let unknown = NSLocalizedString("unknown", tableName: tableName, comment: "")
            static let robot = NSLocalizedString("robot", tableName: tableName, comment: "")
            static let poopybutthole = NSLocalizedString("poopybutthole", tableName: tableName, comment: "")
            static let alien = NSLocalizedString("alien", tableName: tableName, comment: "")
        }
    }
}

