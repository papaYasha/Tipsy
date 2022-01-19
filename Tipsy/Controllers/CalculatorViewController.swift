//
//  ViewController.swift
//  Tipsy
//
//  Created by Macbook on 19.01.22.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    // MARK: - IBOutlet
        
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    // MARK: - Properties
    
    var peopleNumber = 0
    var tipAmount = 0.0
    var outcome = "0.0"
    var billTotal = 0.0

    // MARK: - IBAction
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        let buttonTitle = sender.currentTitle!
        let titleMinusPercent = String(buttonTitle.dropLast())
        let doubleTitle = Double(titleMinusPercent)!
        tipAmount = doubleTitle / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        peopleNumber = Int(sender.value)
    }
    
    @IBAction func hideKeyboardTapGesture(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billTextField.text!
             if bill != "" {
                 billTotal = Double(bill)!
                 let result = billTotal * (1 + tipAmount) / Double(peopleNumber)
                 outcome = String(format: "%.2f", result)
        }
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = outcome
            destinationVC.tip = Int(tipAmount * 100)
            destinationVC.split = peopleNumber
        }
    }
}

