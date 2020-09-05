//
//  UserController.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 8/24/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import Foundation

class UserController {
    
    var users: [User] = [User(name: "Asher", isExtra: false), User(name: "Harmony", isExtra: false), User(name: "Ahava", isExtra: false)]
    
    func addUser(newUser: User) {
        users.append(newUser)
    }
    
    func deleteUser(user: User) {
        if let index = users.firstIndex(of: user) {
            users.remove(at: index)
        }
    }
}
