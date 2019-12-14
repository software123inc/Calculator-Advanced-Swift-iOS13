//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private weak var previoiusCalcButtonSender: UIButton?
    
    private var previousKeyPressWasOperator = false
    private var calculator = CalculatorLogic()
    
    private var displayValue:Double? {
        get {
            if let displayText = displayLabel.text, let number = Double(displayText) {
                return number
            }
            
            return nil
        }
        set {
            if let d = newValue {
                if floor(d) == d {
                    displayLabel.text = String(Int(d))
                }
                else {
                    displayLabel.text = String(d)
                }
            }
        }
    }
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
        if let calcMethod = sender.currentTitle, let d = displayValue {
            calculator.setNumber(d)
            
            if let result = calculator.calculate(symbol: calcMethod) {
                displayValue = result
            }
            
            if ["+", "-", "×", "÷"].contains(calcMethod) {
                previoiusCalcButtonSender = sender
                previoiusCalcButtonSender?.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
                previousKeyPressWasOperator = true
            }
            else {
                previousKeyPressWasOperator = false
            }
        }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
        if let numValue = sender.currentTitle {
            if numValue == "." && (displayLabel.text?.contains(".") ?? false) {
                //no-op
            }
            else if previousKeyPressWasOperator || displayLabel.text == nil || (displayLabel.text == "0" && numValue != ".") {
                displayLabel.text = numValue
            }
            else {
                displayLabel.text?.append(contentsOf: numValue)
            }
        }
        
        previoiusCalcButtonSender?.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        previoiusCalcButtonSender = nil
        
        previousKeyPressWasOperator = false
    }
}

