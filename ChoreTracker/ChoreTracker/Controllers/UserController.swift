//
//  UserController.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 8/24/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import Foundation

class UserController {
    
    // Temporary users for testing
    var users: [User] = [User(name: "Asher"), User(name: "Harmony"), User(name: "Ahava")]
    
    func addUser(newUser: User) {
        users.append(newUser)
    }
    
    func deleteUser(user: User) {
        if let index = users.firstIndex(of: user) {
            users.remove(at: index)
        }
        
        // TODO: remove user from chore user lists
    }
}
