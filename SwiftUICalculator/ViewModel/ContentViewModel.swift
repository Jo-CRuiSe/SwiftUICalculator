//
//  ContentViewModel.swift
//  SwiftUICalculator
//
//  Created by Jo Cruise on 2024/5/10.
//

import Foundation
import SwiftUI

enum lastOprationType {
    case operand
    case operation
    case equal
    case plusMinus
    case percent
    case clear
}

public class ContentViewModel:ObservableObject{
    @Published var display: String = "0" {
        didSet {
            saveResult()
        }
    }
    @Published var action: Action?
    @Published var constantlyLit: Bool = false
    @Published var ACPressed = false
    
    
    private var operandStack: [String] = []
    private var operatorStack: [String] = []
    private var lastPressedButton: lastOprationType = .clear
    private var shouldClearAll: Bool = true
    private var lastNum = ""
    private var lastOperator = ""
    var canDeleteLastDigit = true
    var stacked = false
    
    
    let displayKey: String = "display"
    
    init() {
        getLastResult()
        operandStack.append(display)
    }
    
    func buttonPressed(_ button: CalcButton) {
        canDeleteLastDigit = true
        
        stacked = true
        
        if let text = button.buttonText {
            // if button has text, it will be the one of 0~9 or AC or %.
            if text == "AC" {
                constantlyLit = false
                shouldClearAll.toggle()
                if shouldClearAll == false{
                    if operatorStack.count != 0 {
                        if lastPressedButton == .operand {
                            _ = operandStack.popLast()
                            operandStack.append("0")
                            display = "0"
                        }
                        if lastPressedButton == .operation {
                            operandStack.append("0")
                            display = "0"
                        }
                    }else {
                        clearAll()
                    }
                } else {
                    clearAll()
                }
                lastPressedButton = .clear
            } else if text == "%" {
                canDeleteLastDigit = false
                if operandStack.last == "0" && operandStack.last == nil {
                    lastPressedButton = .percent
                    return
                } else if lastPressedButton == .operand || lastPressedButton == .percent || lastPressedButton == .equal {
                    let numString = operandStack.popLast() ?? "0"
                    let num = (convertToDouble(numString) ?? 0.0) / 100.0
                    operandStack.append(String(num))
                    display = convertToString(num)
                } else if lastPressedButton == .operation {
                    let numString = operandStack.popLast() ?? "0"
                    let num = (convertToDouble(numString) ?? 0.0) / 100.0
                    operandStack.append(numString)
                    operandStack.append(String(num))
                    display = convertToString(num)
                }
                lastPressedButton = .percent
            } else if text == "." {
                constantlyLit = false
                lastPressedButton = .operand
                let operand = (operandStack.popLast() ?? "0").appending(".")
                operandStack.append(operand)
            } else {
                constantlyLit = false
                if lastPressedButton == .operand || lastPressedButton == .plusMinus{
                    var operand = operandStack.popLast() ?? "0"
                    let formattedOperand = operand.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: "")
                    if operand == "0" {
                        operand = text
                    } else if operand == "-0" {
                        operand = "-" + text
                    } else if formattedOperand.count < 9{
                        var stringFormat = operand
                        stringFormat = stringFormat.replacingOccurrences(of: ",", with: "")
                        stringFormat.append(text)
                        let doubleFormat = convertToDouble(stringFormat) ?? 0.0
                        operand = convertToString(doubleFormat)
                    }
                    operandStack.append(operand)
                    lastPressedButton = .operand
                } else if lastPressedButton == .clear || lastPressedButton == .percent || lastPressedButton == .equal {
                    _ = operandStack.popLast()
                    operandStack.append(text)
                }
                else {
                    display = text
                    operandStack.append(text)
                }
                lastPressedButton = .operand
            }
        } else if let action = button.action {
            canDeleteLastDigit = false
            
            if lastPressedButton == .operation && action != .equals && action != .plusMinus{
                _ = operatorStack.popLast()
            }
            
            switch action {
            case .plusMinus:
                if lastPressedButton == .operation {
                    operandStack.append("-0")
                    display = "-0"
                } else {
                    var last = operandStack.popLast() ?? "0"
                    if last.first == "-" {
                        last.removeFirst()
                    } else {
                        last = "-" + last
                    }
                    operandStack.append(last)
                    display = last
                }
                lastPressedButton = .plusMinus
            case .divide:
                constantlyLit = true
                lastPressedButton = .operation
                operatorStack.append("/")
                self.action = .divide
                operatorPressed()
            case .multiply:
                constantlyLit = true
                lastPressedButton = .operation
                operatorStack.append("*")
                self.action = .multiply
                operatorPressed()
            case .subtract:
                constantlyLit = true
                lastPressedButton = .operation
                operatorStack.append("-")
                self.action = .subtract
                operatorPressed()
            case .add:
                constantlyLit = true
                lastPressedButton = .operation
                operatorStack.append("+")
                self.action = .add
                operatorPressed()
            case .equals:
                constantlyLit = false
                equalButtonPressed()
                lastPressedButton = .equal
            }
            
        }
        
        display = operandStack.last ?? "0"
        print("operandStack: \(operandStack)")
        print("operatorStack: \(operatorStack)")
    }
    
    private func judgeOperatorPriority(operation: String) -> Int{
        switch operation {
        case "+":
            return 1
        case "-":
            return 1
        case "*":
            return 2
        case "/":
            return 2
        default:
            return 0
        }
    }
    
    private func clearAll() {
        display = "0"
        action = nil
        constantlyLit = false
        canDeleteLastDigit = false
        ACPressed = true
        operandStack = []
        operatorStack = []
        stacked = false
        lastNum = ""
        lastOperator = ""
    }
    
    
    
    private func solve(leftNum: String, operation: String, rightNum: String) -> String{
        let operandLeft = convertToDouble(leftNum) ?? 0.0
        let operandRight = convertToDouble(rightNum) ?? 0.0
        var answer = 0.0
        
        switch operation {
        case "+":
            answer = operandLeft + operandRight
        case "-":
            answer = operandLeft - operandRight
        case "*":
            answer = operandLeft * operandRight
        case "/":
            answer = operandLeft / operandRight
        default:
            break
        }
        print(answer)
        let answerString = convertToString(answer)
        return answerString
    }
    
    private func equalButtonPressed() {
        canDeleteLastDigit = false
        
        if lastPressedButton == .operation,
           let operand = operandStack.last
        {
            operandStack.append(operand)
        }
        
        if operatorStack.count == 1{
            guard
                let operation = operatorStack.popLast(),
                let rightNum = operandStack.popLast(),
                let leftNum = operandStack.popLast()
            else {return}
            
            lastOperator = operation
            lastNum = rightNum
            let answer = solve(leftNum: leftNum, operation: operation, rightNum: rightNum)
            operandStack.append(answer)
            display = answer
        } else if operatorStack.count == 2{
            guard
                let secondOperator = operatorStack.popLast(),
                let firstOperator = operatorStack.popLast(),
                let thirdNum = operandStack.popLast(),
                let secondNum = operandStack.popLast(),
                let firstNum = operandStack.popLast()
            else { return }
            
            lastOperator = secondOperator
            lastNum = thirdNum
            let answer1 = solve(leftNum: secondNum, operation: secondOperator, rightNum: thirdNum)
            let answer2 = solve(leftNum: firstNum, operation: firstOperator, rightNum: answer1)
            operandStack.append(answer2)
            display = answer2
        } else {
            // count == 0
            if lastNum == "" && lastOperator == ""
            {
                display = operandStack.last ?? "0"
            } else {
                let operand = operandStack.popLast() ?? "0"
                let answer = solve(leftNum: operand, operation: lastOperator, rightNum: lastNum)
                operandStack.append(answer)
                display = answer
            }
            
        }
    }
    
    func operatorPressed() {
        if operatorStack.count == 1{
            return
        } else if operatorStack.count == 2{
            guard
                let firstOperator = operatorStack.first,
                let secondOperator = operatorStack.last
            else { return }
            
            if judgeOperatorPriority(operation: firstOperator) >= judgeOperatorPriority(operation: secondOperator),
               let secondOperator = operatorStack.popLast(),
               let firstOperator = operatorStack.popLast() ,
               let rightNum = operandStack.popLast() ,
               let leftNum = operandStack.popLast()
            {
                let answer = solve(leftNum: leftNum, operation: firstOperator, rightNum: rightNum)
                operandStack.append(answer)
                operatorStack.append(secondOperator)
                print(answer)
                display = answer
            } else {
                return
            }
        } else {
            guard
                let thirdOperator = operatorStack.popLast(),
                let secondOperator = operatorStack.popLast(),
                let firstOperator = operatorStack.popLast()
            else { return }
            
            if
                let thirdNum = operandStack.popLast(),
                let secondNum = operandStack.popLast(),
                let firstNum = operandStack.popLast()
            {
                if judgeOperatorPriority(operation: thirdOperator) == judgeOperatorPriority(operation: firstOperator) {
                    // + x +
                    let answer1 = solve(leftNum: secondNum, operation: secondOperator, rightNum: thirdNum)
                    let answer2 = solve(leftNum: firstNum, operation: firstOperator, rightNum: answer1)
                    operandStack.append(answer2)
                    operatorStack.append(thirdOperator)
                    display = answer2
                } else {
                    // + x x
                    let answer = solve(leftNum: secondNum, operation: secondOperator, rightNum: thirdNum)
                    operandStack.append(answer)
                    operatorStack.append(firstOperator)
                    operatorStack.append(thirdOperator)
                    display = answer
                }
            } else {
                return
            }
        }
    }
    
    func userSwiped() {
        guard
            canDeleteLastDigit,
            var lastOperand = operandStack.popLast(),
            lastOperand != "0"
        else { return }
        _ = lastOperand.popLast()
        if lastOperand == "" {
            lastOperand = "0"
        }
        operandStack.append(lastOperand)
        display = lastOperand
    }
    
    func getLastResult() {
        guard
            let data = UserDefaults.standard.data(forKey: displayKey),
            let savedResult = try? JSONDecoder().decode(String.self, from: data)
        else { return }
        
        self.display = savedResult
    }
    
    func saveResult() {
        if let encodedData = try? JSONEncoder().encode(display) {
            UserDefaults.standard.set(encodedData, forKey: displayKey)
        }
        
    }
    
   
}

func convertToString(_ number: Double, maximumFractionDigits: Int = 15) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = maximumFractionDigits
    formatter.minimumFractionDigits = 0
    formatter.roundingMode = .halfUp
    
    return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
}

func convertToDouble(_ value: String) -> Double? {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter.number(from: value)?.doubleValue
}
