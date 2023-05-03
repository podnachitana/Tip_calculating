//
//  ViewController.swift
//  Tip_calculating
//
//  Created by Tatiana Zudina on 03.05.2023.
//

import UIKit

class CalculatorViewController: UIViewController {
	
	@IBOutlet weak var billTextField: UITextField!
	@IBOutlet weak var zeroPctButton: UIButton!
	@IBOutlet weak var tenPctButton: UIButton!
	@IBOutlet weak var twentyPctButton: UIButton!
	
	@IBOutlet weak var d: UILabel!
	
	var tip = 0.10
	var numberOfPeople = 2
	var billTotal = 0.0
	var finalResult = "0.0"
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	
	@IBAction func tipChanged(_ sender: UIButton) {
		
		billTextField.endEditing(true)
		
		zeroPctButton.isSelected = false
		tenPctButton.isSelected = false
		twentyPctButton.isSelected = false
		
		sender.isSelected = true
		
		let buttonTitle = sender.currentTitle!
		let buttonTitleMinusPercentSign =  String(buttonTitle.dropLast())
		let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
		tip = buttonTitleAsANumber / 100
		
	}
	
	
	
	@IBAction func stepperValueChanged(_ sender: UIStepper) {
		
		d.text = String(format: "%.0f", sender.value)
		numberOfPeople = Int(sender.value)
	}
	
	
	
	@IBAction func calculatePressed(_ sender: UIButton) {
		let bill = billTextField.text!
		if bill != "" {
			billTotal = Double(bill)!
			let result = billTotal * (1 + tip) / Double(numberOfPeople)
			let resultTo2DecimalPlaces = String(format: "%.2f", result)
			finalResult = String(format: "%.2f", result)
		}
		
		self.performSegue(withIdentifier: "goToResult", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goToResult" {
			let destinationVC = segue.destination as! ResultsViewController
			destinationVC.result = finalResult
			destinationVC.tip = Int(tip * 100)
			destinationVC.split = numberOfPeople
		}
	}
	
}

