//
//  Chore.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 7/30/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import Foundation

struct Chore: Codable, Equatable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case frequency
        case instructions
        case users
    }
    
    var name: String
    var frequency: String
    var instructions: String
    var users: [User]
    var nextUser: User {
        get {
            if users.count > 0 {
                return users[0]
            } else {
                return User(name: "No users")
            }
        }
    }
    
    static func == (lhs: Chore, rhs: Chore) -> Bool {
        if lhs.name == rhs.name {
            return true
        } else {
            return false
        }
    }
    
    init(name: String, users: [User], frequency: String, instructions: String) {
        self.name = name
        self.users = users
        self.frequency = frequency
        self.instructions = instructions
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.frequency = try container.decode(String.self, forKey: .frequency)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        
        var usersContainer = try container.nestedUnkeyedContainer(forKey: .users)
        var users: [User] = []
        
        while usersContainer.isAtEnd == false {
            let user = try usersContainer.decode(User.self)
            users.append(user)
        }
        self.users = users
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(frequency, forKey: .frequency)
        try container.encode(instructions, forKey: .instructions)
        
        var usersContainer = container.nestedUnkeyedContainer(forKey: .users)
        for user in users {
            try usersContainer.encode(user)
        }
    }
}
