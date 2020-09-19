//
//  User.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 7/30/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import Foundation

struct User: Codable, Equatable {
    
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        if lhs.name == rhs.name {
            return true
        } else {
            return false
        }
    }
}
