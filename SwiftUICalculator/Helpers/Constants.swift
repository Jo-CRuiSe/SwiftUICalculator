//
//  Constants.swift
//  SwiftUICalculator
//
//  Created by Jo Cruise on 2024/5/10.
//

import Foundation

public class Constants {
    
    static let padding: CGFloat = 15.0
    
    static let calcButtons = [
        [CalcButton(color: .lightGray, buttonText: "AC"), CalcButton(color: .lightGray,action: .plusMinus), CalcButton(color: .lightGray, buttonText: "%"), CalcButton(color: .orange, action: .divide)],
        [CalcButton(color: .darkGray, buttonText: "7"), CalcButton(color: .darkGray,buttonText: "8"), CalcButton(color: .darkGray, buttonText: "9"), CalcButton(color: .orange, action: .multiply)],
        [CalcButton(color: .darkGray, buttonText: "4"), CalcButton(color: .darkGray,buttonText: "5"), CalcButton(color: .darkGray, buttonText: "6"), CalcButton(color: .orange, action: .subtract)],
        [CalcButton(color: .darkGray, buttonText: "1"), CalcButton(color: .darkGray,buttonText: "2"), CalcButton(color: .darkGray, buttonText: "3"), CalcButton(color: .orange, action: .add)],
        [CalcButton(color: .darkGray, buttonText: "0"), CalcButton(color: .darkGray,buttonText: "."), CalcButton(color: .orange, action: .equals)],
    ]
    
}

enum CalcColor: String {
    case lightGray = "CalcLightGray"
    case darkGray = "CalcDarkGray"
    case orange = "CalcOrange"
}

public enum Action: String {
    case plusMinus = "plus.forwardslash.minus"
    case divide = "divide"
    case multiply = "multiply"
    case subtract = "minus"
    case add = "plus"
    case equals = "equal"
    
}

public class ShakeText {
    static let tiggerDict = ["101": "fasdf", "500":"You're shaking iPhone!"]
}

private var listViewModel = TextReplacementViewModel()

extension String {
    
    func formatString() -> String {
//        if listViewModel.items.values.contains(self) {
//            return self
//        }
        
        var display = self.replacingOccurrences(of: "+", with: "")
        var hasDot = true
        let isNegtive = (display.first == "-")
        display = display.replacingOccurrences(of: "-", with: "")
        
        if display.contains(",") {
            return display
        } else if (display == "nan" || display == "inf"){
            display = NSLocalizedString("Error", comment: "")
            return display
         } else {
            var integerPart = display.components(separatedBy: ".").first ?? "0"
            var decimalPart = ""

            if display.components(separatedBy: ".").count > 1 {
                decimalPart = display.components(separatedBy: ".").last ?? "0"
            } else {
                hasDot = false
            }
            
            for i in stride(from: integerPart.count - 3, to: 0, by: -3) {
                let index = integerPart.index(integerPart.startIndex, offsetBy: i)
                integerPart.insert(",", at: index)
            }
            
            if isNegtive {
                integerPart = "-" + integerPart
            }
            
            if hasDot {
                return integerPart + "." + decimalPart
            } else {
                return integerPart + decimalPart
            }
           
        }
    }
}
