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
    
    var chore: Chore? {
        if let choreController = choreController,
            let choreIndex = choreIndex {
            return choreController.chores[choreIndex]
        } else {
            return nil
        }
    }
    
    var choreIndex: Int?
    var choreController: ChoreController?
    var userController: UserController?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    func updateViews() {
        if let chore = chore {
            choreNameLabel.text = chore.name
            nextUserLabel.text = "Next User:  \(chore.nextUser.name)"
            frequencyLabel.text = chore.frequency
            instructionsTextView.text = chore.instructions == "Instructions:  " ? "Instructions:  None" : chore.instructions
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? AddChoreViewController {
            destination.chore = chore
            destination.userController = userController
            destination.choreController = choreController
        }
    }

    @IBAction func completeChore(_ sender: UIButton) {
        if let choreController = choreController,
            let chore = chore {
            choreController.completeChore(chore: chore)
        }
        updateViews()
    }
    
    @IBAction func skipUser(_ sender: UIButton) {
        if let choreController = choreController,
            let chore = chore {
            choreController.skipUser(chore: chore)
        }
        updateViews()
    }
    
    @IBAction func deleteChore(_ sender: UIButton) {
        if let chore = chore {
            choreController?.deleteChore(chore: chore)
            
            navigationController?.popViewController(animated: true)
        }
    }
}
