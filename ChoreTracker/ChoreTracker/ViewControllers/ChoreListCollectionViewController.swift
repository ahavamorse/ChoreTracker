//
//  ChoreListCollectionViewController.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 8/10/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import UIKit

class ChoreListCollectionViewController: UICollectionViewController {
    
    // Stretch goal: allow users to sign into families to access chores from multiple devices

    let choreController = ChoreController()
    let userController = UserController()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        userController.getUsers { _ in
            self.choreController.getChores { _ in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.updateViews()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    func updateViews() {
        if !activityIndicator.isAnimating {
            collectionView.reloadData()
            
            if userController.users.isEmpty {
                addFirstUser()
            } else if choreController.chores.isEmpty {
                addFirstChore()
            }
        }
    }
    
    func addFirstUser() {
        performSegue(withIdentifier: "ViewUserSegue", sender: self)
    }
    
    func addFirstChore() {
        let alertController = UIAlertController(title: "No Chores", message: "Please add chores to complete.", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .default) { _ in
            self.performSegue(withIdentifier: "AddChoreSegue", sender: self)
        }
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
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
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChoreCell", for: indexPath) as? ChoreCollectionViewCell else {
            fatalError("Cell is not a ChoreCollectionViewCell") }
        
        cell.chore = choreController.alphabetizedChores[indexPath.row]
            
        return cell
    }
}
