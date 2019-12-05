//
//  TodayViewController.swift
//  Calculator Widget
//
//  Created by Stephanie Bowles on 12/5/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit
import NotificationCenter
import RPN

class TodayViewController: UIViewController, NCWidgetProviding, UITextFieldDelegate {
        
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var calculatorView: UIView!
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
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        self.textField.delegate = self
    }
   
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        try? digitAccumulator.add(digit: .number(sender.tag))
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
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
    
        
        completionHandler(NCUpdateResult.newData)
    }
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        switch activeDisplayMode {
        case .compact:
            preferredContentSize = maxSize
            calculatorView.isHidden = true
        case .expanded:
            preferredContentSize = CGSize(width: maxSize.width, height: 300)
            calculatorView.isHidden = false
        @unknown default:
            break
        }
    }
}
