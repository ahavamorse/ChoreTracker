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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func addUser(_ sender: UIBarButtonItem) {
        if let userController = userController,
            let name = UserNameTextField.text {
            userController.addUser(newUser: User(name: name))        }
        navigationController?.popViewController(animated: true)
    }
    
}
