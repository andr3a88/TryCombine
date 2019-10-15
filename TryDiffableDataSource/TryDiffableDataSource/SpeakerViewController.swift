//
//  SpeakerViewController.swift
//  TryDiffableDataSource
//
//  Created by Andrea Stevanato on 15/10/2019.
//  Copyright © 2019 Andrea Stevanato. All rights reserved.
//

import UIKit

final class SpeakerViewController: UIViewController {
    
    @IBOutlet weak private var collectionView: UICollectionView!
    private var speakers: [Speaker] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        populateCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.register(UINib(nibName: String(describing: SpeakerCollectionViewCell.self), bundle: nil),
                                forCellWithReuseIdentifier: String(describing: SpeakerCollectionViewCell.self))
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func populateCollectionView() {
        for i in 1..<100 {
            speakers.append(
                Speaker(
                    name: "User \(i)",
                    twitterHandler: "@Twitter \(i)",
                    imageURL: URL(string: "https://pragmaconference.com/assets/images/speakers/jeroen_bakker.jpg")
                )
            )
        }
        collectionView.reloadData()
    }
}

extension SpeakerViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SpeakerCollectionViewCell.self),
                                                            for: indexPath) as? SpeakerCollectionViewCell else {
                                                                fatalError("Could not dequeue cell")
        }
        cell.display(speaker: speakers[indexPath.item])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return speakers.count
    }
}

extension SpeakerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 62)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension SpeakerViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("Selected \(indexPath.item)")
    }
}
