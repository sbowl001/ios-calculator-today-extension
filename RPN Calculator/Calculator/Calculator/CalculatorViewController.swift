//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Stephanie Bowles on 9/10/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit
import RPN
class CalculatorViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var textField: UITextField!
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        formatter.maximumIntegerDigits = 20//before decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 20 //after decimal
        //why?
        return formatter
    }()
    
    private var calculator = Calculator() {
        didSet {
            if let value = calculator.topValue {
                textField.text = numberFormatter.string(from: value as NSNumber)
            } else {
                textField.text = ""
            }
        }
    }
    
    private var digitAccumulator = DigitAccumulator(){
        didSet {
            if let value = digitAccumulator.value() {
                textField.text = numberFormatter.string(from: value as NSNumber)
            } else {
                textField.text = ""
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
 
    }
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        try? digitAccumulator.add(digit: .number(sender.tag))
        
    }
    
    @IBAction func decimalButtonTapped(_ sender: UIButton) {
        try? digitAccumulator.add(digit: .decimalPoint)
    }
    @IBAction func returnButtonTapped(_ sender: UIButton) {
        //take the value from the accumulator and push it to the stack
        if let value = digitAccumulator.value() {
            calculator.push(number: value)
        }
        digitAccumulator.clear()
    }
    @IBAction func divideButtonTapped(_ sender: UIButton) {
        calculator.push(operator: .divide)
    }
    @IBAction func multiplyButtonTapped(_ sender: UIButton) {
        calculator.push(operator: .multiply)
    }
    @IBAction func subtractButtonTapped(_ sender: UIButton) {
        calculator.push(operator: .subtract)
    }
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        calculator.push(operator: .add)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        calculator.clear()
        digitAccumulator.clear()
        return true
    }
}


// Access Control
//Public, Private, Internal, FilePrivate, Open
//Internal = available to everyone within the project

//filePrivate = private to the file
