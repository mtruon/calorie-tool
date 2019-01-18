//
//  ViewController.swift
//  CalorieTool
//
//  Created by MICHAEL on 2018-12-18.
//  Copyright © 2018 Michael Truong. All rights reserved.
//

import UIKit

class IntroductionViewController: UIViewController {
    @IBOutlet weak var beginButton: UIButton!
    @IBOutlet weak var introTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling for the introduction button
        introTextView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        introTextView.layer.cornerRadius = 20
        introTextView.clipsToBounds = true
    }

    // MARK: Navigation
    @IBAction func unwindToIntroduction(unwindSegue: UIStoryboardSegue) {
        
    }
}

