//
//  ChoreDetailsViewController.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 8/24/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import UIKit

class ChoreDetailsViewController: UIViewController {

    @IBOutlet weak var choreNameLabel: UILabel!
    @IBOutlet weak var nextUserLabel: UILabel!
    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    var chore: Chore?
    var nextUser: User?
    var choreController: ChoreController?
    var userController: UserController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    
    func updateViews() {
        if let chore = chore {
            choreNameLabel.text = chore.name
            nextUserLabel.text = "Next User: \(nextUser?.name)"
            frequencyLabel.text = chore.frequency
            instructionsTextView.text = chore.instructions
        
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let destination = segue.destination as? AddChoreViewController else { return }
        
        destination.chore = chore
        destination.userController = userController
    }

    @IBAction func completeChore(_ sender: UIButton) {
        if let choreController = choreController,
            let chore = chore,
            let nextUser = nextUser {
            choreController.completeChore(chore: chore, user: nextUser)
        }
    }
    
    @IBAction func skipUser(_ sender: UIButton) {
        if let chore = chore,
            let nextUser = nextUser {
            guard let index = chore.users.firstIndex(of: nextUser) else { return }
            self.nextUser = chore.users[index + 1]
        }
    }
}
