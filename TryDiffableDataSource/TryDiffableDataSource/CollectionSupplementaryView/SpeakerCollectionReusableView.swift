//
//  SpeakerCollectionReusableView.swift
//  TryDiffableDataSource
//
//  Created by Andrea Stevanato on 15/10/2019.
//  Copyright © 2019 Andrea Stevanato. All rights reserved.
//

import UIKit

final class SpeakerCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak private var titleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
    }
    
    func display(title: String) {
        titleLabel.text = title
    }
}
