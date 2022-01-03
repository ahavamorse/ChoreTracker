//
//  NewUserViewController.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 8/31/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController, UITextFieldDelegate {

    var userController: UserController?
    
    @IBOutlet weak var UserNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserNameTextField.becomeFirstResponder()
    }
    
    @IBAction func saveUser(_ sender: Any) {
        addUser(sender)
    }
    
    @IBAction func addUser(_ sender: Any) {
        if let username = UserNameTextField.text,
           username.isEmpty {
            let alertController = UIAlertController(title: "Empty Name", message: "Please enter a name for this new user.", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "Ok", style: .default)
            alertController.addAction(alertAction)
            
            self.present(alertController, animated: true)
            return
        }
        
        if let userController = userController,
            let name = UserNameTextField.text {
            let newUser = User(name: name)
            
            if userController.users.contains(newUser) {
                // Already has a user with this name
                
                let alertController = UIAlertController(title: "Same Name", message: "A user with this name already exists. Please choose a different name.", preferredStyle: .alert)
                
                let alertAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
                    nothing()
                }
                alertController.addAction(alertAction)
                
                self.present(alertController, animated: true, completion: nil)
                

                func nothing() {
                    return
                }
                
            } else {
                userController.addUser(newUser: newUser)
                navigationController?.popViewController(animated: true)
            }
        }
    }
}
