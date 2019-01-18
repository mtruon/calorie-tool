//
//  ResultsViewController.swift
//  CalorieTool
//
//  Created by MICHAEL on 2019-01-15.
//  Copyright © 2019 Michael Truong. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    // Implicity unwrapped optional because it's assigned via segue
    var responses: [Answer]!
    let onePoundCalories: Float = 3500.0
    
    @IBOutlet weak var bmrLabel: UILabel!
    @IBOutlet weak var maintenanceLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculateResult()
    }
    
    func calculateResult() {
        let age = responses[0].value
        let weight = responses[1].value
        let height = responses[2].value / 2.54
        let gender = responses[3].text
        let activity = responses[4].value
        let goal = responses[5].text
        let target = responses[6].value
        let weeks = responses[7].value
        var bmr: Float?
        
        if gender == "Female" {
            bmr = 655 + (4.35 * weight) + (4.7 * height) - (4.7 * age)
        } else {
            bmr = 66 + (6.23 * weight) + (12.7 * height) - (6.8 * age)
        }
        
        let maintenanceCalories = bmr! * activity
        let caloricDailyGoal = (onePoundCalories * target)/(weeks * 7)
        
        bmrLabel.text = "\(bmr!) cals"
        maintenanceLabel.text = "\(maintenanceCalories) cals"
        targetLabel.text = "\(maintenanceCalories - caloricDailyGoal) cals"
        descriptionLabel.text = goal == "Lose" ? "To \(goal) \(Int(target)) lbs in \(Int(weeks)) weeks you will need to eat at a deficit of \(Int(caloricDailyGoal)) cals" : "To \(goal) \(Int(target)) lbs in \(Int(weeks)) weeks you will need to eat at a surplus of \(Int(caloricDailyGoal)) cals"
    
    }
    
}
