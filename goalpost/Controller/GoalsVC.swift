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
    
    var goals = [Goal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetch { (success) in
            if success {
                if goals.count > 0 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            }
            tableView.reloadData()
        }
    }
    
    @IBAction func addGoalButtonWasPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else { return }
        presentDetail(createGoalVC)
    }
    
    @IBAction func unwindToGoalsVC(segue: UIStoryboardSegue) {
        
    }
    
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
}

extension GoalsVC {
    func fetch(_ completion: (_ success: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        do {
            goals = try managedContext.fetch(Goal.fetchRequest())
            completion(true)
        } catch {
            debugPrint("!!!!!!!!!!!!! Could not fetch: \(error.localizedDescription) !!!!!!!!!!!!")
        }
    }
}
