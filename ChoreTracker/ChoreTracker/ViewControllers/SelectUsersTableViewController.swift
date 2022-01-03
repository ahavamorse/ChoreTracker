//
//  SelectUsersTableViewController.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 9/14/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import UIKit

class SelectUsersTableViewController: UITableViewController {

    var choreController: ChoreController?
    var userController: UserController?
    var users: [User]?
    var chore: Chore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Stretch goal: sort users by selected and not selected
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let userController = userController else { return 0 }
        return userController.users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? SelectUserTableViewCell else { fatalError("Cell is not a SelectUserTableViewCell") }

        guard let userController = userController else { return cell}
        
        let user = userController.users[indexPath.row]
        
        if let users = users {
            cell.userIsSelected = users.contains(user)
        } else {
            cell.userIsSelected = false
        }
        cell.user = user

        return cell
    }

    @IBAction func saveUsers(_ sender: UIBarButtonItem) {
        var users: [User] = []
        
        for index in 0...tableView.numberOfRows(inSection: 0) - 1 {
            if let cell = tableView.cellForRow(at: [0, index]) as? SelectUserTableViewCell {
                
                if cell.userIsSelected == true,
                    let user = cell.user {
                    users.append(user)
                }
            }
        }
        
        if users.count > 0 {
            
            navigationController?.popViewController(animated: true)
            if let viewController = navigationController?.visibleViewController as? AddChoreViewController {
                viewController.users = users
            }
        } else {
            // No users selected
            
            let alertController = UIAlertController(title: "No Users", message: "Each chore must have at least one user", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
                nothing()
            }
            alertController.addAction(alertAction)
            
            self.present(alertController, animated: true, completion: nil)
            

            func nothing() {
                return
            }
        }
    }
}
