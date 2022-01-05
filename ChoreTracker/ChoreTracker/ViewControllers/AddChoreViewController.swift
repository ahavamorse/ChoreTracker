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
        choreNameTextField.becomeFirstResponder()
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
            choreName.isEmpty == false,
            let frequency = frequencyTextField.text,
           frequency.isEmpty == false,
            let instructions = instructionsTextView.text,
            let users = users {
            
            if let oldChore = chore {
                let newChore = Chore(name: choreName, users: users, frequency: frequency, instructions: instructions)
                
                choreController.editChore(from: oldChore, into: newChore)
                
            } else {
                let newChore = Chore(name: choreName, users: users, frequency: frequency, instructions: instructions)
                choreController.addChore(newChore: newChore)
            }
            navigationController?.popViewController(animated: true)
        } else {
            let alertController = UIAlertController(title: "Missing Information", message: "Please finish filling out the chore information before saving.", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func choreNameDone(_ sender: Any) {
        choreNameTextField.resignFirstResponder()
        frequencyTextField.becomeFirstResponder()
    }
    
    @IBAction func frequencyDone(_ sender: Any) {
        frequencyTextField.resignFirstResponder()
    }
}
