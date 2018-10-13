//
//  GoalsVC.swift
//  goalpost
//
//  Created by DokeR on 05.09.2018.
//  Copyright © 2018 DokeR. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var undoViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var undoView: UIView!
    @IBOutlet weak var undoViewHeightConstraint: NSLayoutConstraint!
    
    var deletedGoal: Goal?
    
    let managedContext = appDelegate?.persistentContainer.viewContext
    
    var goals = [Goal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
        
        managedContext?.undoManager = UndoManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchCoreDataObjects()
        tableView.reloadData()
    }
    
    func fetchCoreDataObjects() {
        fetch { (success) in
            if success {
                if goals.count > 0 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            }
        }
    }
    
    func showUndoGoalView() {
        UIView.animate(withDuration: 0.5) {
            self.undoViewHeightConstraint.constant = 45
            self.undoView.layoutIfNeeded()
        }
        //hide view after 3 sec
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            UIView.animate(withDuration: 0.5) {
                self.undoViewHeightConstraint.constant = 0
                self.undoView.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func addGoalButtonWasPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else { return }
        presentDetail(createGoalVC)
    }
    
    @IBAction func undoDeleteButtonPressed(_ sender: Any) {
        undoDeletting()
        UIView.animate(withDuration: 0.5) {
            self.undoViewHeightConstraint.constant = 0
            self.undoView.layoutIfNeeded()
        }
        fetch { (success) in
            tableView.reloadData()
            tableView.isHidden = false
        }
        
    }
    
    @IBAction func unwindToGoalsVC(segue: UIStoryboardSegue) {}
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalTableCell{
            let goal = goals[indexPath.row]
            cell.configCell(goal: goal)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            self.showUndoGoalView()
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (_, indexPath) in
            self.setProgressForGoal(atIndexPath: indexPath)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        addAction.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.6156862745, blue: 0.1333333333, alpha: 1)
        
        return [deleteAction, addAction]
    }
    
}


//Core Data extension
extension GoalsVC {
    func fetch(_ completion: (_ success: Bool) -> ()) {
        if let context = managedContext {
            do {
                goals = try context.fetch(Goal.fetchRequest())
                completion(true)
            } catch {
                debugPrint("!!!!!!!!!!!!! Could not fetch: \(error.localizedDescription) !!!!!!!!!!!!")
            }
        }
    }
    
    func removeGoal(atIndexPath indexPath: IndexPath) {
        managedContext?.delete(goals[indexPath.row])
        
        do {
            try managedContext?.save()
        } catch {
            debugPrint("!!!!!!!!!!!!! Could not save: \(error.localizedDescription) !!!!!!!!!!!!")
        }
    }
    
    func undoDeletting() {
        managedContext?.undoManager?.undo()
       do {
            try managedContext?.save()
        } catch {
            debugPrint("!!!!!!!!!!!!! Could not save: \(error.localizedDescription) !!!!!!!!!!!!")
        }
    }
    
    func setProgressForGoal(atIndexPath indexPath: IndexPath) {
        let choosenGoal = goals[indexPath.row]
        
        if choosenGoal.goalProgress < choosenGoal.goalCompletionValue {
            choosenGoal.goalProgress = choosenGoal.goalProgress + 1
        } else {
            return
        }
        
        do {
            try managedContext?.save()
        } catch {
            debugPrint("!!!!!!!!!!!!! Could not save progress: \(error.localizedDescription) !!!!!!!!!!!!")
        }
    }
    
}

