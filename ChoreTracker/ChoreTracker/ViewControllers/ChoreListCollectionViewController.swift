//
//  ChoreListCollectionViewController.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 8/10/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import UIKit

class ChoreListCollectionViewController: UICollectionViewController {

    
    let choreController = ChoreController()
    let userController = UserController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView!.register(ChoreCollectionViewCell.self, forCellWithReuseIdentifier: "ChoreCell")

        choreController.addChore(newChore: Chore(name: "Take out trash", users: userController.users, frequency: "", instructions: ""))
        choreController.addChore(newChore: Chore(name: "Put away and load dishwasher", users: userController.users, frequency: "", instructions: ""))
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? ChoreDetailsViewController,
            let indexPath: IndexPath = collectionView.indexPathsForSelectedItems?[0] {
            destination.chore = choreController.chores[indexPath.row]
            destination.nextUser = choreController.chores[indexPath.row].nextUser
            destination.choreController = choreController
            destination.userController = userController
            
        } else if let destination = segue.destination as? AddChoreViewController {
            destination.choreController = choreController
            destination.userController = userController
        }
        
        
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return choreController.chores.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChoreCell", for: indexPath) as? ChoreCollectionViewCell else {
            fatalError("Cell is not a ChoreCollectionViewCell") }
        
        cell.chore = choreController.chores[indexPath.row]
        cell.nextUser = choreController.chores[indexPath.row].nextUser
            
        return cell
    }
}
