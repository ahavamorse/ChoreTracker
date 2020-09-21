//
//  UsersTableViewController.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 9/9/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {

    var userController: UserController?
    var choreController: ChoreController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let userController = userController {
            return userController.users.count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let userController = userController else {
            fatalError("no userController")
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)

        cell.textLabel?.text = userController.users[indexPath.row].name

        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let userController = userController,
                let choreController = choreController {
                
                guard userController.users.count > 1 else {
                    let alertController = UIAlertController(title: "Last User", message: "You must have at least one user", preferredStyle: .alert)
                    
                    let alertAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
                        nothing()
                    }
                    alertController.addAction(alertAction)
                    
                    self.present(alertController, animated: true, completion: nil)

                    func nothing() {
                        return
                    }
                    return
                }
                
                let user = userController.users[indexPath.row]
                
                userController.deleteUser(user: user)
                choreController.removeUser(user: user)
                
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: View details about users such as what chores are theirs next and how many times they've completed each chore
        
        if let destination = segue.destination as? NewUserViewController {
            
            destination.userController = userController
            
        }
    }
    

}
