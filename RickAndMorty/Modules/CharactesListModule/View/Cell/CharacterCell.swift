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
        statusLabel.text = character.status
        genderLabel.text = character.gender
        locationLabel.text = character.location.name
        
        if let url = character.image {
            characterImageView.kf.setImage(with: url)
        } else {
            characterImageView.image = R.Images.noImage
        }
    }
}
