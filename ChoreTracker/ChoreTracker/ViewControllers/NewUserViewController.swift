//
//  NewUserViewController.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 8/31/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController {

    var userController: UserController?
    
    @IBOutlet weak var UserNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addUser(_ sender: UIBarButtonItem) {
        // TODO: Add new users to old chores
        
        if let userController = userController,
            let name = UserNameTextField.text {
            userController.addUser(newUser: User(name: name))        }
        navigationController?.popViewController(animated: true)
    }
    
}
