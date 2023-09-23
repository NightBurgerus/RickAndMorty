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
    @IBOutlet weak var scrollView: CustomScrollView!
    @IBOutlet weak var infoStack: UIStackView!
    
    private var character: Character!
    private let disposeBag = DisposeBag()
    private let logger = Logger()
    private let fontSize = 18.0
    
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
        statusLabel.attributedText   = getStatus()
        speciesLabel.attributedText  = getSpecies()
        typeLabel.attributedText     = getType()
        genderLabel.attributedText   = getGender()
        originLabel.attributedText   = getOrigin()
        locationLabel.attributedText = getLocation()
        createdLabel.attributedText  = getCreated()
        episodesLabel.attributedText = getEpisodes()
        
        setupEpisodes()
        scrollView.layoutIfNeeded()
        
        scrollView
            .rx
            .contentOffset
            .subscribe(onNext: { [weak self] offset in
                guard let self = self else { return }
                if -50...(-1) ~= offset.y {
                    self.characterImageView.transform = CGAffineTransform(scaleX: 1 - offset.y / 1000, y: 1 - offset.y / 1000)
                }
                if offset.y > 0 {
                    self.characterImageView.transform = CGAffineTransform(scaleX: 1 - offset.y / 5000, y: 1 - offset.y / 2000)
                }
                self.characterImageView.alpha = 1 - offset.y / self.characterImageView.frame.height
            })
            .disposed(by: disposeBag)
            
    }
    
    private func setupEpisodes() {
        for episode in character.episode {
            addEpisodeView(episode)
        }
    }

}

private extension CharacterViewController {
    
    private func getEpisodes() -> NSAttributedString {
        return NSAttributedString(string: "\(R.Strings.Characters.episodes):", attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .bold)])
    }
    
    private func getCreated() -> NSAttributedString {
        let created = NSMutableAttributedString(string: "\(R.Strings.Characters.created): ", attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .bold)])
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: character.created) {
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            created.append(NSAttributedString(string: dateFormatter.string(from: date), attributes: [.font: UIFont.systemFont(ofSize: fontSize)]))
        } else {
            created.append(NSAttributedString(string: character.created, attributes: [.font: UIFont.systemFont(ofSize: fontSize)]))
        }
        
        return created
    }
    
    private func getOrigin() -> NSAttributedString {
        let origin = NSMutableAttributedString(string: "\(R.Strings.Characters.origin): ", attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .bold)])
        origin.append(NSAttributedString(string: character.origin.name, attributes: [.font: UIFont.systemFont(ofSize: fontSize)]))
        
        return origin
    }
    
    private func getType() -> NSAttributedString {
        let type = NSAttributedString(string: "\(R.Strings.Characters.type): ", attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .bold)])
        let typeValue = NSAttributedString(string: character.type, attributes: [.font: UIFont.systemFont(ofSize: fontSize)])
        let result = NSMutableAttributedString(attributedString: type)
        result.append(typeValue)
        
        return result
    }
    
    private func getSpecies() -> NSAttributedString {
        let species = NSAttributedString(string: "\(R.Strings.Characters.species): ", attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .bold)])
        
        let curSpecies: String!
        switch character.species.lowercased() {
        case "human": curSpecies = R.Strings.Species.human
        case "cronenberg": curSpecies = R.Strings.Species.cronenberg
        case "humanoid": curSpecies = R.Strings.Species.humanoid
        case "animal": curSpecies = R.Strings.Species.animal
        case "mythological creature": curSpecies = R.Strings.Species.mythologicalCreature
        case "robot": curSpecies = R.Strings.Species.robot
        case "poopybutthole": curSpecies = R.Strings.Species.poopybutthole
        case "alien": curSpecies = R.Strings.Species.alien
        default: curSpecies = R.Strings.Species.unknown
        }
        let attrCurSpecies = NSAttributedString(string: curSpecies, attributes: [.font: UIFont.systemFont(ofSize: fontSize)])
        let result = NSMutableAttributedString(attributedString: species)
        result.append(attrCurSpecies)
        return result
    }
    
    private func getStatus() -> NSAttributedString {
        let status = NSAttributedString(string: "\(R.Strings.Characters.status): ", attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .bold)])
        
        let curStatus: String!
        switch character.status.lowercased() {
        case "alive": curStatus = R.Strings.Status.alive
        case "dead": curStatus =  R.Strings.Status.dead
        default: curStatus = R.Strings.Status.unknown
        }
        let attrCurStatus = NSAttributedString(string: curStatus, attributes: [.font: UIFont.systemFont(ofSize: fontSize)])
        let result = NSMutableAttributedString(attributedString: status)
        result.append(attrCurStatus)
        return result
    }
    
    private func getGender() -> NSAttributedString {
        let gender = NSMutableAttributedString(string: "\(R.Strings.Characters.gender): ", attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .bold)])
        
        let genderValue: String!
        switch character.gender.lowercased() {
        case "female": genderValue =  R.Strings.Genders.female
        case "genderless": genderValue =  R.Strings.Genders.genderless
        case "male": genderValue =  R.Strings.Genders.male
        default: genderValue =  R.Strings.Genders.unknown
        }
        gender.append(NSAttributedString(string: genderValue, attributes: [.font: UIFont.systemFont(ofSize: fontSize)]))
        
        return gender
    }
    
    private func getLocation() -> NSAttributedString {
        let location = NSMutableAttributedString(string: "\(R.Strings.Characters.location): ", attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .bold)])
        location.append(NSAttributedString(string: character.location.name, attributes: [.font: UIFont.systemFont(ofSize: fontSize)]))
        return location
    }
}

private extension CharacterViewController {
    func addEpisodeView(_ episodeName: URL) {
        let episode = UIView()
        let nameLabel = UILabel()
        let arrow = UIImageView(image: UIImage(systemName: "arrow.right")!)
        arrow.tintColor = R.Colors.appForeground
        if let lastSlash = episodeName.absoluteString.lastIndex(of: "/") {
            let s = episodeName.absoluteString
            nameLabel.text = "#" + String(s[s.index(lastSlash, offsetBy: 1)..<s.endIndex])
        } else {
            nameLabel.text = "\(episodeName.absoluteString.dropFirst(20))"
        }
        
        episode.addSubview(nameLabel)
        episode.addSubview(arrow)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        arrow.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: episode.leadingAnchor, constant: 8),
            nameLabel.centerYAnchor.constraint(equalTo: episode.centerYAnchor),
            arrow.trailingAnchor.constraint(equalTo: episode.trailingAnchor, constant: -8),
            arrow.centerYAnchor.constraint(equalTo: episode.centerYAnchor),
            arrow.heightAnchor.constraint(equalToConstant: 25),
            arrow.widthAnchor.constraint(equalToConstant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: arrow.leadingAnchor, constant: -8)
        ])
        
        infoStack.addArrangedSubview(episode)
        
        episode.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            episode.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
