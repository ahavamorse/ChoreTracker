//
//  ChoreListCollectionViewController.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 8/10/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import UIKit

class ChoreListCollectionViewController: UICollectionViewController {
    
    // TODO: Split chores into families (with passwords?) URGENT

    let choreController = ChoreController()
    let userController = UserController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
//        self.collectionView!.register(ChoreCollectionViewCell.self, forCellWithReuseIdentifier: "ChoreCell")
        
        choreController.getChores { (error) in
            if let error = error {
                NSLog("Error: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        
        userController.getUsers { (error) in
            if let error = error {
                NSLog("Error: \(error)")
            }
        }
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
            destination.chore = choreController.chores[indexPath.row]
            destination.choreController = choreController
            destination.userController = userController
            
        } else if let destination = segue.destination as? AddChoreViewController {
            destination.choreController = choreController
            destination.userController = userController
        } else if let destination = segue.destination as? UsersTableViewController {
            destination.userController = userController
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
    
    @IBAction func loadChores(_ sender: UIBarButtonItem) {
        collectionView.reloadData()
    }
}
