//
//  Speaker.swift
//  TryDiffableDataSource
//
//  Created by Andrea Stevanato on 15/10/2019.
//  Copyright © 2019 Andrea Stevanato. All rights reserved.
//

import Foundation

struct Speaker {
    private let identifier: UUID = UUID()
    
    let name: String
    let twitterHandler: String
    private(set) var imageURL: URL?
    
    static func createFake(count: Int) -> [Speaker] {
        Array(0..<count).map {
            Speaker(
                name: "User \($0)",
                twitterHandler: "@Twitter \($0)",
                imageURL: URL(string: "https://pragmaconference.com/assets/images/speakers/jeroen_bakker.jpg")
            )
        }
    }
}

extension Speaker: Hashable {
    
    // Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    // Equatable - Inherited from Hashable
    static func == (lhs: Speaker, rhs: Speaker) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

