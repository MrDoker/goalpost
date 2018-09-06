//
//  FinishGoalVC.swift
//  goalpost
//
//  Created by DokeR on 06.09.2018.
//  Copyright © 2018 DokeR. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController {
    
    @IBOutlet weak var createGoalButton: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    
    var goalDescription: String!
    var goalType: GoalType!

    override func viewDidLoad() {
        super.viewDidLoad()
        //createGoalButton.bindToKeyboard()
        createGoalButton.removeFromSuperview()
        pointsTextField.inputAccessoryView = createGoalButton
    }
    
    func initData(description: String, type: GoalType) {
        goalDescription = description
        goalType = type
    }
    
    @IBAction func createGoalButtonWasPressed(_ sender: Any) {
        save { (success) in
            if success {
                performSegue(withIdentifier: "unwindToGoalsVC", sender: nil)
            }
        }
    }
    
    func save(completion: (_ success: Bool) -> ()) {
        guard let goalCompletionValue = pointsTextField.text, pointsTextField.text != "0" else { return completion(false) }
        guard let managetContext = appDelegate?.persistentContainer.viewContext else { return completion(false)}
        let goal = Goal(context: managetContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(goalCompletionValue) ?? Int32(1)
        goal.goalProgress = Int32(0)
        
        do {
            try managetContext.save()
            completion(true)
        } catch {
            debugPrint("!!!!!!!!!!!!! Could not save: \(error.localizedDescription) !!!!!!!!!!!!")
            completion(false)
        }
    }
    
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismissDetail()
    }
    

}
