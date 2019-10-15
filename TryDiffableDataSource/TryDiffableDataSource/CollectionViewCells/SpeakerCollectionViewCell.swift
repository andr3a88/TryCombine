//
//  SpeakerCollectionViewCell.swift
//  TryDiffableDataSource
//
//  Created by Andrea Stevanato on 15/10/2019.
//  Copyright © 2019 Andrea Stevanato. All rights reserved.
//

import UIKit
import Nuke

final class SpeakerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var avatarImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var twitterHandler: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        avatarImageView.image = UIImage(named: "User_Avatar")
    }
    
    func display(speaker: Speaker) {
        titleLabel.text = speaker.name
        twitterHandler.text = speaker.twitterHandler
        
        guard let imageURL = speaker.imageURL else { return }
        Nuke.loadImage(with: imageURL, into: avatarImageView)
    }

}
