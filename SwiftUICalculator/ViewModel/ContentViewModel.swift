//
//  ContentViewModel.swift
//  SwiftUICalculator
//
//  Created by Jo Cruise on 2024/5/10.
//

import Foundation
import SwiftUI

public class ContentViewModel:ObservableObject{
    @Published var display: String = "0" {
        didSet {
            saveResult()
        }
    }
    @Published var action: Action?
    @Published var shouldClear: Bool = false
    @Published var newAction: Bool = false
    @Published var stacked: Bool = false
    @Published var inputOrder: String = ""
    @Published var ACPressed = false
    
    //private var stack: [String] = [""]
    private var prevPriority = 0;
    private var currentPriority = 0;
    private var operandStack: [String] = []
    private var operatorStack: [String] = []
    private var lastPressedButton = "operand"
    var canDeleteLastDigit = true
    
    let displayKey: String = "display"
    
    init() {
        getLastResult()
        operandStack.append(display)
    }
    
    func buttonPressed(_ button: CalcButton) {
        canDeleteLastDigit = true
        shouldClear = false
        stacked = true
        if button.buttonText == "AC" {
            clearAll()
            lastPressedButton = "operand"
            ACPressed = true
        } else if let text = button.buttonText {
            // restrict input
            guard display.count < 9 && !(text == "." && display.contains(".")) else { return }
            
            if text == "%"{
                if operandStack.last == "0" {
                    return
                }
                if lastPressedButton == "operand" {
                    let numString = operandStack.popLast() ?? "0"
                    let num = (Double(numString) ?? 0.0) / 100.0
                    operandStack.append(String(num))
                    display = convertToString(num)
                } else {
                    let numString = operandStack.popLast() ?? "0"
                    let num = (Double(numString) ?? 0.0) / 100.0
                    operandStack.append(numString)
                    operandStack.append(String(num))
                    display = convertToString(num)
                }
            }
            else if text == "." {
                let operand = (operandStack.popLast() ?? "0").appending(".")
                operandStack.append(operand)
            }
            
            else {
                if lastPressedButton == "operand" {  // 如果上次输入是数字，进行追加
                    var operand = operandStack.popLast() ?? "0"
                    if operand == "0" {
                        operand = text
                    } else {
                        operand.append(text)
                    }
                    operandStack.append(operand)
                    display = operand
                }
                else {  //如果上次输入是算符，显示清空
                    display = text
                    operandStack.append(text)
                }
            }
            lastPressedButton = "operand"
        } else if let action = button.action {
            shouldClear = true
            canDeleteLastDigit = false
            if lastPressedButton == "operator" {    //如果上次输入是算符，更改算符
                _ = operatorStack.popLast()
            }
            
            prevPriority = currentPriority;
            
            // 处理算符
            switch action {
            case .plusMinus:
                if display.contains("-") {
                    let last = operandStack.popLast() ?? "-0"
                    var lastString = String(last)
                    lastString.removeFirst()
                    operandStack.append(lastString)
                } else {
                    var last = operandStack.popLast() ?? "0"
                    last = "-" + last
                    operandStack.append(last)
                }
                shouldClear = false
            case .divide:
                self.action = .divide
                newAction = true
                operatorStack.append("/")
                currentPriority = 2
            case .multiply:
                self.action = .multiply
                newAction = true
                operatorStack.append("*")
                currentPriority = 2
            case .subtract:
                self.action = .subtract
                newAction = true
                operatorStack.append("-")
                currentPriority = 1
            case .add:
                self.action = .add
                newAction = true
                operatorStack.append("+")
                currentPriority = 1
            case .equals:
                equalButtonPressed()
            }
            
            let currentOperator = operatorStack.popLast() ?? ""
            //var prevOperator = operatorStack.popLast() ?? ""
            // 判断前一个算符是否为空，如果是直接结束
            guard let prevOperator = operatorStack.popLast()
            else {
                display = operandStack.last ?? "0"
                operatorStack.append(currentOperator)
                lastPressedButton = "operator"
                print("operandStack: \(operandStack)")
                print("operationStack: \(operatorStack)")
                return
            }
            prevPriority = judgeOperatorPriority(operation: prevOperator)
            currentPriority = judgeOperatorPriority(operation: currentOperator)
            //当当前个算符等级比上一个低时才结算
            if currentPriority <= prevPriority {
                var rightNum = operandStack.popLast() ?? "0"
                var leftNum = operandStack.popLast() ?? "0"
                var answer = solve(leftNum: leftNum, operation: prevOperator, rightNum: rightNum)
                operandStack.append(answer)
                
                //                // 判断除数是否为0
                //                if operandStack.last == "inf" {
                //                    display = "Error"
                //                    return
                //                }
                prevPriority = judgeOperatorPriority(operation: operatorStack.last ?? "")
                // 判断是否为_+_*_+_ 或 _+_*_* 有三个元素的形式
                
                guard let pprevOperator = operatorStack.popLast()
                else {
                    // 栈内没有多余运算符
                    display = operandStack.last ?? "0"
                    operatorStack.append(currentOperator)
                    lastPressedButton = "operator"
                    print("operandStack: \(operandStack)")
                    print("operationStack: \(operatorStack)")
                    return
                }
                
                if currentPriority == judgeOperatorPriority(operation: pprevOperator) {
                    // 是这种形式现在操作数栈里只有两个数, pprevOperator 和 currentOerator 都为 1 级
                    rightNum = operandStack.popLast() ?? "0"
                    leftNum = operandStack.popLast() ?? "0"
                    answer = solve(leftNum: leftNum, operation: pprevOperator, rightNum: rightNum)
                    operandStack.append(answer)
                } else {
                    operatorStack.append(pprevOperator)
                }
                
                
            } else {
                operatorStack.append(prevOperator)
                
            }
            operatorStack.append(currentOperator)
            
            shouldClear = true
            lastPressedButton = "operator"
        }
        display = operandStack.last ?? "0"
        print("operandStack: \(operandStack)")
        print("operationStack: \(operatorStack)")
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
        shouldClear = false
        newAction = false
        stacked = false
        operandStack = ["0"]
        //if ACPressedTimes == 0 {
        operatorStack = []
        //}
        
    }
    
    private func convertToString(_ number: Double) -> String {
        return String(format: "%g", number)
    }
    
    private func solve(leftNum: String, operation: String, rightNum: String) -> String{
        let operandLeft = Double(leftNum) ?? 0.0
        let operandRight = Double(rightNum) ?? 0.0
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
        let answerString = convertToString(answer)
        return answerString
    }
    
    private func equalButtonPressed() {
        canDeleteLastDigit = false
        shouldClear = false
        if operandStack.count < 2 {
            // 没有算符，等于原式
            if operatorStack.count == 0{
                return
            } else {
                // 有算符
                let operand = operandStack.popLast() ?? "0"
                let operation = operatorStack.popLast() ?? ""
                let answer = solve(leftNum: operand, operation: operation, rightNum: operand)
                operandStack.append(answer)
                return
            }
        }
        
        
        // 按下等于号前操作数栈内元素只可能有两个或三个
        if operandStack.count == 2 {
            guard let rightNum = operandStack.popLast() else { return }
            guard let leftNum = operandStack.popLast() else { return }
            guard let operation = operatorStack.popLast() else { return }
            let answer = solve(leftNum: leftNum, operation: operation, rightNum: rightNum)
            operandStack.append(answer)
            
        } else {
            // 只可能是_+_*_类似组合
            guard let rightNum = operandStack.popLast() else { return }
            guard let operation = operatorStack.popLast() else { return }
            guard let middleNum = operandStack.popLast() else { return }
            guard let pervOperation = operatorStack.popLast() else { return }
            guard let leftNum = operandStack.popLast() else { return }
            var answer = solve(leftNum: middleNum, operation: operation, rightNum: rightNum)
            answer = solve(leftNum: leftNum, operation: pervOperation, rightNum: answer)
            operandStack.append(answer)
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
