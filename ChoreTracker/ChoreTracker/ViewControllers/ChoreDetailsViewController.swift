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
    var choreController: ChoreController?
    var userController: UserController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    
    func updateViews() {
        if let chore = chore {
            choreNameLabel.text = chore.name
            nextUserLabel.text = "Next User: \(chore.nextUser.name)"
            frequencyLabel.text = chore.frequency
            instructionsTextView.text = chore.instructions
        
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destination = segue.destination as? AddChoreViewController else { return }
        
        destination.chore = chore
        destination.userController = userController
    }

    @IBAction func completeChore(_ sender: UIButton) {
        if let choreController = choreController,
            let chore = chore {
            choreController.completeChore(chore: chore)
        }
    }
    
    @IBAction func skipUser(_ sender: UIButton) {
        if let choreController = choreController,
            let chore = chore {
            choreController.skipUser(chore: chore)
        }
    }
}
