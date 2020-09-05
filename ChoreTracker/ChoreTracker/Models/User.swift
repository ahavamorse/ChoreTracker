//
//  User.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 7/30/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import Foundation

struct User: Equatable {
    var name: String
    var isExtra: Bool
    // var password: String
    // var chores: [Chore]
    
    static func == (lhs: User, rhs: User) -> Bool {
        if lhs.name == rhs.name {
            return true
        } else {
            return false
        }
    }
}
