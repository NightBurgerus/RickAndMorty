//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Чебупелина on 22.09.2023.
//

import UIKit
import Kingfisher

final class CharacterViewController: UIViewController {
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var episodesLabel: UILabel!
    @IBOutlet weak var episodesTableView: UITableView!
    
    private var character: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (navigationController as? NavigationController)?.setTitle(character.name)
    }
    
    func setup(character: Character) {
        self.character = character
    }
    
    private func setupUI() {
        if let url = character.image {
            characterImageView.kf.setImage(with: url)
        }
        statusLabel.text = getStatus(character)
        speciesLabel.text = getSpecies()
        typeLabel.text = getType()
        genderLabel.text = getGender(character)
        originLabel.text = getOrigin()
        locationLabel.text = getLocation(character)
        createdLabel.text = getCreated()
        episodesLabel.text = getEpisodes()
    }

}

private extension CharacterViewController {
    
    private func getEpisodes() -> String {
        var result = "\(R.Strings.Characters.episodes): "
        return result
    }
    
    private func getCreated() -> String {
        var result = "\(R.Strings.Characters.created): "
        
        result += character.created
        
        return result
    }
    
    private func getOrigin() -> String {
        var result = "\(R.Strings.Characters.origin): "
        
        result += character.origin.name
        
        return result
    }
    
    private func getType() -> String {
        var result = "\(R.Strings.Characters.type): "
        
        result += character.type
        
        return result
    }
    
    private func getSpecies() -> String {
        var result = "\(R.Strings.Characters.species): "
        
        result += character.species
        
        return result
    }
    
    private func getStatus(_ character: Character) -> String {
        var result = "\(R.Strings.Characters.status): "
        switch character.status.lowercased() {
        case "alive": result += R.Strings.Status.alive
        case "dead": result +=  R.Strings.Status.dead
        default: result +=  R.Strings.Status.unknown
        }
        return result
    }
    
    private func getGender(_ character: Character) -> String {
        var result = "\(R.Strings.Characters.gender): "
        switch character.gender.lowercased() {
        case "female": result +=  R.Strings.Genders.female
        case "genderless": result +=  R.Strings.Genders.genderless
        case "male": result +=  R.Strings.Genders.male
        default: result +=  R.Strings.Genders.unknown
        }
        return result
    }
    
    private func getLocation(_ character: Character) -> String {
        return "\(R.Strings.Characters.location): \(character.location.name)"
    }
}
