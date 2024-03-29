//
//  SelectUserTableViewCell.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 9/14/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import UIKit

class SelectUserTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var checkboxButton: UIButton!
    
    var userIsSelected: Bool?
    var user: User? {
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateViews() {
        if let user = user {
            userNameLabel.text = user.name
        }

        if userIsSelected == true {
            checkboxButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            checkboxButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    @IBAction func selectUser(_ sender: UIButton) {
        if let userIsSelected = userIsSelected {
            self.userIsSelected = !userIsSelected
        }
        updateViews()
    }
}
