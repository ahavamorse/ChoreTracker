//
//  ChoreCollectionViewCell.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 8/11/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import UIKit

class ChoreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var choreNameLabel: UILabel!
    @IBOutlet weak var nextUserLabel: UILabel!
    
    var chore: Chore?
    var nextUser: User? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        
        choreNameLabel?.text = chore?.name
        nextUserLabel?.text = nextUser?.name
        print("Chore: \(chore!.name)")
        print("Next user: \(nextUser!.name)")
    }
}
