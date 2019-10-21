//
//  SpeakerViewController.swift
//  TryDiffableDataSource
//
//  Created by Andrea Stevanato on 15/10/2019.
//  Copyright © 2019 Andrea Stevanato. All rights reserved.
//

import UIKit

final class SpeakerViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    @IBOutlet weak private var collectionView: UICollectionView!
    
    // New DiffableDataSource only from iOS 13
    @available(iOS 13.0, *)
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Speaker>? = nil
    private var speakers: [Speaker] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        populateCollectionView()
        
        // Add new speaker
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.populateCollectionView(with: Speaker.createFake(count: 5))
        }
    }
    
    func setupCollectionView() {
        collectionView.register(UINib(nibName: String(describing: SpeakerCollectionViewCell.self), bundle: nil),
                                forCellWithReuseIdentifier: String(describing: SpeakerCollectionViewCell.self))
        
        collectionView.delegate = self
        
        if #available(iOS 13.0, *) {
            setupCollectionViewdDiffableDataSource()
        } else {
            collectionView.dataSource = self
        }
    }
    
    @available(iOS 13.0, *)
    func setupCollectionViewdDiffableDataSource() {
        dataSource = .init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, speaker) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SpeakerCollectionViewCell.self),
                                                                for: indexPath) as? SpeakerCollectionViewCell else {
                                                                    fatalError("Could not dequeue cell")
            }
            
            cell.display(speaker: speaker)
            return cell
        })
    }
    
    func populateCollectionView() {
        speakers = Speaker.createFake(count: 100)
        
        if #available(iOS 13.0, *) {
            var snapshot = NSDiffableDataSourceSnapshot<Section, Speaker>()
            snapshot.appendSections([Section.main])
            snapshot.appendItems(self.speakers, toSection: Section.main)
            self.dataSource?.apply(snapshot)
        } else {
            collectionView.reloadData()
        }
    }
    
    func populateCollectionView(with speakers: [Speaker]) {
        let previousSpeakers = self.speakers
        self.speakers = speakers
        
        if #available(iOS 13.0, *), var snapshot = dataSource?.snapshot() {
            snapshot.deleteItems(previousSpeakers)
            snapshot.appendItems(speakers)
            dataSource?.apply(snapshot, animatingDifferences: true)
        } else {
            collectionView.performBatchUpdates({
            if previousSpeakers.count > speakers.count {
                let reloadIndexPaths = Array(0..<speakers.count).map({ IndexPath(item: $0, section: 0) })
                let deleteIndexPaths = Array(speakers.count..<previousSpeakers.count).map({ IndexPath(item: $0, section: 0) })
                collectionView.reloadItems(at: reloadIndexPaths)
                collectionView.deleteItems(at: deleteIndexPaths)
            } else if previousSpeakers.count < speakers.count {
                let reloadIndexPaths = Array(0..<previousSpeakers.count).map({ IndexPath(item: $0, section: 0) })
                let insertIndexPaths = Array(previousSpeakers.count..<speakers.count).map({ IndexPath(item: $0, section: 0) })
                collectionView.reloadItems(at: reloadIndexPaths)
                collectionView.insertItems(at: insertIndexPaths)
            } else {
               let indexPaths = Array(0..<speakers.count).map({ IndexPath(item: $0, section: 0) })
               collectionView.reloadItems(at: indexPaths)
            }
        }, completion: nil)
        }
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
