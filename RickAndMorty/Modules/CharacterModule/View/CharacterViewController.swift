//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Чебупелина on 22.09.2023.
//

import UIKit
import Kingfisher
import RxCocoa
import RxSwift

private enum Constants: String {
    case cellIdentifier = "EpisodeCell"
}

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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoStack: UIStackView!
    
    private var character: Character!
    private let disposeBag = DisposeBag()
    private let logger = Logger()
    
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
        statusLabel.text = getStatus()
        speciesLabel.text = getSpecies()
        typeLabel.text = getType()
        genderLabel.text = getGender()
        originLabel.text = getOrigin()
        locationLabel.text = getLocation()
        createdLabel.text = getCreated()
        episodesLabel.text = getEpisodes()
        
        setupEpisodes()
    }
    
    private func setupEpisodes() {
        for episode in character.episode {
            addEpisodeView(episode)
        }
    }

}

private extension CharacterViewController {
    
    private func getEpisodes() -> String {
        return "\(R.Strings.Characters.episodes): "
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
        
        switch character.species.lowercased() {
        case "human": result += R.Strings.Species.human
        case "cronenberg": result += R.Strings.Species.cronenberg
        case "humanoid": result += R.Strings.Species.humanoid
        case "animal": result += R.Strings.Species.animal
        case "mythological creature": result += R.Strings.Species.mythologicalCreature
        case "robot": result += R.Strings.Species.robot
        case "poopybutthole": result += R.Strings.Species.poopybutthole
        case "alien": result += R.Strings.Species.alien
        default: result += R.Strings.Species.unknown
        }
        
        return result
    }
    
    private func getStatus() -> String {
        var result = "\(R.Strings.Characters.status): "
        switch character.status.lowercased() {
        case "alive": result += R.Strings.Status.alive
        case "dead": result +=  R.Strings.Status.dead
        default: result +=  R.Strings.Status.unknown
        }
        return result
    }
    
    private func getGender() -> String {
        var result = "\(R.Strings.Characters.gender): "
        switch character.gender.lowercased() {
        case "female": result +=  R.Strings.Genders.female
        case "genderless": result +=  R.Strings.Genders.genderless
        case "male": result +=  R.Strings.Genders.male
        default: result +=  R.Strings.Genders.unknown
        }
        return result
    }
    
    private func getLocation() -> String {
        return "\(R.Strings.Characters.location): \(character.location.name)"
    }
}

private extension CharacterViewController {
    func addEpisodeView(_ episodeName: URL) {
        let episode = UIView()
        let nameLabel = UILabel()
        let arrow = UIImageView(image: UIImage(named: "no-image-rick")!)
        
        nameLabel.text = "\(episodeName.absoluteString.dropFirst(10))"
        
        episode.addSubview(nameLabel)
        episode.addSubview(arrow)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        arrow.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: episode.leadingAnchor, constant: 8),
            nameLabel.centerYAnchor.constraint(equalTo: episode.centerYAnchor),
            arrow.trailingAnchor.constraint(equalTo: episode.trailingAnchor, constant: -8),
            arrow.centerYAnchor.constraint(equalTo: episode.centerYAnchor),
            arrow.heightAnchor.constraint(equalToConstant: 20),
            arrow.widthAnchor.constraint(equalToConstant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: arrow.leadingAnchor, constant: -8)
        ])
        
        infoStack.addArrangedSubview(episode)
        
        episode.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            episode.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            episode.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            episode.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
