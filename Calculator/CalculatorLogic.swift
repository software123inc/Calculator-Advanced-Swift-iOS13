//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Tim Newton on 12/13/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    private var number:Double?
    private var intermediateCalculation: (n1:Double, symbol:String)?
    
    mutating func setNumber(_ newVal: Double) {
        self.number = newVal
    }
    
    mutating func calculate(symbol: String) -> Double? {
        var result:Double?
        
        if let n = number {
            if symbol == "AC" {
                result = 0
                self.intermediateCalculation = nil
            }
            else if symbol == "+/-" {
                result = n * -1
            }
            else if symbol == "%" {
                result = n * 0.01
            }
            else if symbol == "=" {
                result = performTwoNumberCalculation(n)
            }
            else {
                self.intermediateCalculation = (n1: n, symbol: symbol)
                //result = 0
            }
            
        }
        
        return result
    }
    
    private func performTwoNumberCalculation(_ n2:Double) -> Double? {
        var result:Double?
        
        if let symbol = self.intermediateCalculation?.symbol, let n1 = self.intermediateCalculation?.n1 {
            switch symbol {
            case "+":
                result = n1 + n2
            case "-":
                result = n1 - n2
            case "×":
                result = n1 * n2
            case "÷":
                if n2 != 0 {
                    result = n1 / n2
                }
            default:
                fatalError("Unsupported operator '\(symbol)'")
            }
        }
        
        return result
    }
}
