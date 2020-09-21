//
//  ChoreListCollectionViewController.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 8/10/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import UIKit

class ChoreListCollectionViewController: UICollectionViewController {
    
    // TODO: Split chores into families (with passwords?)

    let choreController = ChoreController()
    let userController = UserController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userController.users.count == 0 {
            performSegue(withIdentifier: "ViewUserSegue", sender: self)
            
            let alertController = UIAlertController(title: "No Users", message: "Please add users before adding chores", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
                nothing()
            }
            alertController.addAction(alertAction)
            
            self.present(alertController, animated: true, completion: nil)
            

            func nothing() {
                return
            }

        }
        // Register cell classes
//        self.collectionView!.register(ChoreCollectionViewCell.self, forCellWithReuseIdentifier: "ChoreCell")
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        choreController.getChores { (error) in
            if let error = error {
                NSLog("Error: \(error)")
            }
        }
        collectionView.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? ChoreDetailsViewController,
            let indexPath: IndexPath = collectionView.indexPathsForSelectedItems?[0] {
            
            destination.choreIndex = indexPath.row
            destination.choreController = choreController
            destination.userController = userController
            
        } else if let destination = segue.destination as? AddChoreViewController {
            destination.choreController = choreController
            destination.userController = userController
            
        } else if let destination = segue.destination as? UsersTableViewController {
            destination.userController = userController
            destination.choreController = choreController
            
        }
        
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return choreController.chores.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // TODO: Allow sorting alphabetically or by next user etc.
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChoreCell", for: indexPath) as? ChoreCollectionViewCell else {
            fatalError("Cell is not a ChoreCollectionViewCell") }
        
        cell.chore = choreController.chores[indexPath.row]
            
        return cell
    }
}
