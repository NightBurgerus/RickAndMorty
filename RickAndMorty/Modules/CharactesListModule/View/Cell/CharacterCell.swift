//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Чебупелина on 20.09.2023.
//

import UIKit
import Kingfisher

final class CharacterCell: UITableViewCell {
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(character: Character) {
        nameLabel.text = character.name
        statusLabel.text = getStatus(character)
        genderLabel.text = getGender(character)
        locationLabel.text = getLocation(character)
        
        if let url = character.image {
            characterImageView.kf.setImage(with: url)
        } else {
            characterImageView.image = R.Images.noImage
        }
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
