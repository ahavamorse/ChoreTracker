//
//  ChoreController.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 8/10/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import Foundation

class ChoreController {
    
    var chores: [Chore] = []
    
    func completeChore(chore: Chore, user: User) {
        if let index = chore.users.firstIndex(of: user) {
            chore.users.remove(at: index)
            chore.users.append(user)
        }
    }
    
    func skipUser(chore: Chore, user: User) {
        
    }
    
    func addChore(newChore: Chore) {
        chores.append(newChore)
    }
    
    func editChore(from oldChore: Chore, into newChore: Chore) {
        guard let index = chores.firstIndex(of: oldChore) else { return }
        chores.remove(at: index)
        chores.insert(newChore, at: index)
    }
    
    func deleteChore(chore: Chore) {
        if let index = chores.firstIndex(of: chore) {
            chores.remove(at: index)
        }
    }
}
