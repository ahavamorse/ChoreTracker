//
//  SelectUsersTableViewController.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 9/14/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import UIKit

class SelectUsersTableViewController: UITableViewController {

    var userController: UserController?
    var chore: Chore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // TODO: Split users into two groups: secected and not selected
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
        
        // Configure the cell...
        if let chore = chore {
            cell.userIsSelected = chore.users.contains(user)
        } else {
            cell.userIsSelected = false
        }
        cell.user = user

        return cell
    }

    @IBAction func saveUsers(_ sender: UIBarButtonItem) {
        let users: [User] = []
        
        for index in 0...tableView.numberOfRows(inSection: 0) - 1 {
            if let cell = tableView.cellForRow(at: [0, index]) as? SelectUsersTableViewController {
                
            }
        }
    }
}
