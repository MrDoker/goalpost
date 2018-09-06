//
//  CreateGoalVC.swift
//  goalpost
//
//  Created by DokeR on 06.09.2018.
//  Copyright © 2018 DokeR. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermButton: UIButton!
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func nextButtonWasPressed(_ sender: Any) {
        
    }
    
    @IBAction func shortTermButtonWasPressed(_ sender: Any) {
        
    }
    
    @IBAction func longTermButtonWasPressed(_ sender: Any) {
        
    }
    
    @IBAction func backButtonWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
}
