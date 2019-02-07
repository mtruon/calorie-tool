//
//  QuestionViewController.swift
//  CalorieTool
//
//  Created by MICHAEL on 2019-01-15.
//  Copyright © 2019 Michael Truong. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var questionCountLabel: UILabel!
    @IBOutlet weak var questionTitleLabel: UILabel!
    
    @IBOutlet weak var inputAccessoryLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var inputStackView: UIStackView!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButtonA: RoundedButton!
    @IBOutlet weak var singleButtonB: RoundedButton!
    @IBOutlet weak var singleButtonC: RoundedButton!
    @IBOutlet weak var singleButtonD: RoundedButton!
    @IBOutlet weak var singleButtonE: RoundedButton!
    @IBOutlet var singleButtons: [RoundedButton]!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedInputLabel: UILabel!
    @IBOutlet weak var rangedAccessoryLabel: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var nextButton: RoundedButton!
    
    var questionIndex = 0
    var questions: [Question] = [
        Question(text: "How old are you?",
                 type: .input,
                 answers: [Answer(text: "y/o", value: 0)]),
        Question(text: "How much do you weigh?",
                 type: .input,
                 answers: [Answer(text: "lbs", value: 0)]),
        Question(text: "How tall are you?",
                 type: .input,
                 answers: [Answer(text: "cm", value: 0)]),
        Question(text: "What is your gender?",
                 type: .single,
                 answers: [Answer(text: "Female", value: 0),
                           Answer(text: "Male", value: 1),
                           Answer(text: "Unspecified", value: 1)]),
        Question(text: "What is your activity level?",
                 type: .single,
                 answers: [Answer(text: "Sedentary", value: 1.2),
                           Answer(text: "Lightly Active", value: 1.375),
                           Answer(text: "Moderately Active", value: 1.55),
                           Answer(text: "Very Active", value: 1.725),
                           Answer(text: "Extra Active", value: 1.9)]),
        Question(text: "What is your weight-oriented goal?",
                 type: .single,
                 answers: [Answer(text: "Gain", value: 1),
                           Answer(text: "Lose", value: -1)]),
        Question(text: "How many pounds?",
                 type: .ranged,
                 answers: [Answer(text: "lbs", value: 0)]),
        Question(text: "What's your time frame?",
                 type: .ranged,
                 answers: [Answer(text: "week(s)", value: 0)])
    ]
    var answersChosen: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        // Set the age field to be numeric input only
        answerTextField.delegate = self
        answerTextField.keyboardType = .numberPad
    }
    
    
    // MARK: UI Altering Functions
    func updateUI() {
        inputStackView.isHidden = true
        singleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        switch questionIndex {
        case 0...2:
            navigationItem.title = "Basal Metabolic Rate"
        case 3:
            navigationItem.title = "Harris Benedict"
        default:
            navigationItem.title = "Goals"
        }
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        
        questionTitleLabel.text = currentQuestion.text
        questionCountLabel.text = "\(questionIndex + 1) OF \(questions.count)"
        switch currentQuestion.type {
        case .input:
            updateInputStackView(using: currentAnswers)
        case .single:
            updateSingleStackView(using: currentAnswers)
        case .ranged:
            updateRangedStackView(using: currentAnswers)
        }
        
    }
    
    func updateInputStackView(using answers: [Answer]) {
        inputStackView.isHidden = false
        answerTextField.text = nil
        inputAccessoryLabel.text = answers[0].text
    }
    
    func updateSingleStackView(using answers: [Answer]) {
        singleStackView.isHidden = false
        
        for button in singleButtons {
            button.isHidden = true
        }
        
        for i in 0..<answers.count {
            singleButtons[i].isHidden = false
            singleButtons[i].setTitle(answers[i].text, for: .normal)
        }
        
        resetSingleButtonHighlight()
    }
    
    func resetSingleButtonHighlight() {
        let salmonColor = UIColor(red: 1, green: 126/255, blue: 121/255, alpha: 1)
        for button in singleButtons {
            button.backgroundColor = UIColor.white
            button.setTitleColor(salmonColor, for: .normal)
        }
    }
    
    func highlightSingleButton(_ sender: UIButton) {
        let salmonColor = UIColor(red: 1, green: 126/255, blue: 121/255, alpha: 1)
        sender.backgroundColor = salmonColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    func updateRangedStackView(using answers: [Answer]) {
        rangedStackView.isHidden = false
//        rangedSlider.setValue(0.0, animated: false)
        rangedSlider.isEnabled = true
        rangedInputLabel.text = "\(Int(rangedSlider.value))"
        rangedAccessoryLabel.text = answers.first?.text
        
    }
    
    // Called when the user click on the view (outside the UITextField).
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // MARK: Actions
    @IBAction func singleButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        if answersChosen.count > questionIndex {
            answersChosen.removeLast()
            resetSingleButtonHighlight()
        }
        
        switch sender {
        case singleButtons[0]:
            answersChosen.append(currentAnswers[0])
        case singleButtons[1]:
            answersChosen.append(currentAnswers[1])
        case singleButtons[2]:
            answersChosen.append(currentAnswers[2])
        case singleButtons[3]:
            answersChosen.append(currentAnswers[3])
        case singleButtons[4]:
            answersChosen.append(currentAnswers[4])
        case singleButtons[5]:
            answersChosen.append(currentAnswers[5])
        default:
            break
        }
        highlightSingleButton(sender)
    }
    
    @IBAction func rangedAnswerButtonPressed(_ sender: UISlider) {
        updateRangedStackView(using: questions[questionIndex].answers)
    }
    
    
    @IBAction func nextQuestionButtonPressed(_ sender: Any) {
        
        // Grabs input or ranged answers
        if questions[questionIndex].type == .input {
            guard answerTextField.text != nil && answerTextField.text != "" else {
                return
            }
            let textFieldAnswerAsInt: Int? = Int(answerTextField.text!)
            answersChosen.append(Answer(text: answerTextField.text!, value: Float(textFieldAnswerAsInt!)))
        } else if questions[questionIndex].type == .ranged {
            guard rangedSlider.value != 0 else {
                return
            }
            answersChosen.append(Answer(text: "\(Int(rangedSlider.value))", value: Float(Int(rangedSlider.value))))
        }
        
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }

}
