//
//  AddChoreViewController.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 8/24/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import UIKit

class AddChoreViewController: UIViewController {

    @IBOutlet weak var choreNameTextField: UITextField!
    @IBOutlet weak var frequencyTextField: UITextField!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    var userController: UserController?
    var choreController: ChoreController?
    var chore: Chore?
    
    var users: [User]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        users = chore?.users ?? userController?.users

        updateViews()
    }

    func updateViews() {
        if let chore = chore {
            choreNameTextField.text = chore.name
            frequencyTextField.text = chore.frequency
            instructionsTextView.text = chore.instructions
            navigationItem.title = "Edit Chore"
        } else {
            navigationItem.title = "Add Chore"
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SelectUsersTableViewController {
            destination.choreController = choreController
            destination.userController = userController
            destination.users = users
            destination.chore = chore
        }

    }
    

    @IBAction func saveChore(_ sender: UIBarButtonItem) {
        
        if let choreController = choreController,
            let choreName = choreNameTextField.text,
            let frequency = frequencyTextField.text,
            let instructions = instructionsTextView.text,
            let users = users {
            
            if let oldChore = chore {
                
                let newChore = Chore(name: choreName, users: users, frequency: frequency, instructions: instructions)
                
                choreController.editChore(from: oldChore, into: newChore)
                
            } else {
                
                let newChore = Chore(name: choreName, users: users, frequency: frequency, instructions: instructions)
                // TODO: Keep old order of users
                choreController.addChore(newChore: newChore)
            }
        }
        navigationController?.popViewController(animated: true)
    }
}
