//
//  GoalTableCell.swift
//  goalpost
//
//  Created by DokeR on 06.09.2018.
//  Copyright © 2018 DokeR. All rights reserved.
//

import UIKit

class GoalTableCell: UITableViewCell {

    @IBOutlet weak var goalDescriptionLabel: UILabel!
    @IBOutlet weak var goalTypeLabel: UILabel!
    @IBOutlet weak var goalProgressionLabel: UILabel!
    
    func configCell(description: String, type: GoalType, goalProgressAmount: Int) {
        goalDescriptionLabel.text = description
        goalTypeLabel.text = type.rawValue
        goalProgressionLabel.text = String(describing: goalProgressAmount)
    }

}
