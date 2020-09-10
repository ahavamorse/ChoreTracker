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
    
    func completeChore(chore: Chore) -> Chore {
        if let choreIndex = chores.firstIndex(of: chore) {
            let user = chore.nextUser
            chores[choreIndex].users.remove(at: 0)
            chores[choreIndex].users.append(user)
            
            return chores[choreIndex]
        } else {
            return chore
        }
    }
    
    func skipUser(chore: Chore) -> Chore {
        // Can be upgraded later to allow catch up
        if let choreIndex = chores.firstIndex(of: chore) {
            let user = chore.nextUser
            chores[choreIndex].users.remove(at: 0)
            chores[choreIndex].users.append(user)
            
            return chores[choreIndex]
        } else {
            return chore
        }
    }
    
    func addChore(newChore: Chore) {
        chores.append(newChore)
    }
    
    func editChore(from oldChore: Chore, into newChore: Chore) {
        
        if let choreIndex = chores.firstIndex(of: oldChore) {
            chores.remove(at: choreIndex)
            chores.insert(newChore, at: choreIndex)
        }
    }
    
    func deleteChore(chore: Chore) {
        if let index = chores.firstIndex(of: chore) {
            chores.remove(at: index)
        }
    }
}
