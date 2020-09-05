//
//  Chore.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 7/30/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import Foundation

class Chore: Equatable {
    
    var name: String
    var nextUser: User {
        get {
            return users[0]
        }
    }
    var frequency: String
    var users: [User]
    var instructions: String
    
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
}
