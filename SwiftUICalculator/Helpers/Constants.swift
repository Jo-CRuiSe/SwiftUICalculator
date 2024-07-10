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

private var listViewModel = TextReplacementViewModel()

extension String {
    func formatString() -> String {
        let display = self.replacingOccurrences(of: ",", with: "")
        let doubleDisplay = convertToDouble(display) ?? 0.0
        let absValue = abs(doubleDisplay)
        
        if display == "+∞" || display == "NaN" || display == "-∞" {
            return NSLocalizedString("Error", comment: "")
        }
        
        if doubleDisplay == 0 {
            return self
        }
        
        if absValue >= pow(10.0, 160) || absValue <= pow(10.0, -100){
            return NSLocalizedString("Error", comment: "")
        }
        
        if absValue >= pow(10.0, -8) && absValue < pow(10.0, 9){
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 8
            formatter.minimumFractionDigits = 0
            formatter.roundingMode = .halfUp
            
            let decimalPart = String(absValue).components(separatedBy: ".").last ?? ""
            let integerPart = String(absValue).components(separatedBy: ".").first ?? ""
            if integerPart.count + decimalPart.count >= 9 {
                formatter.maximumSignificantDigits = 9
            }

            print(formatter.string(from: NSNumber(value: doubleDisplay)) ?? "\(doubleDisplay)")
            return formatter.string(from: NSNumber(value: doubleDisplay)) ?? "\(doubleDisplay)"
        }
        
        if absValue <= pow(10.0, -8) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .scientific
            formatter.maximumSignificantDigits = 15
            formatter.positiveFormat = "0.#####E0"
            formatter.exponentSymbol = "e"
            
            let formattedString = formatter.string(from: NSNumber(value: doubleDisplay)) ?? "\(doubleDisplay)"
            
            return formattedString
        }
        
        if absValue >= pow(10.0, 9) && absValue < pow(10.0, 10){
            let formatter = NumberFormatter()
            formatter.numberStyle = .scientific
            formatter.maximumSignificantDigits = 15
            formatter.positiveFormat = "0.######E0"
            formatter.exponentSymbol = "e"
            
            let formattedString = formatter.string(from: NSNumber(value: doubleDisplay)) ?? "\(doubleDisplay)"
            
            return formattedString
        }
        
        if absValue >= pow(10.0, 10) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .scientific
            formatter.maximumSignificantDigits = 15
            formatter.positiveFormat = "0.#####E0"
            formatter.exponentSymbol = "e"
            
            let formattedString = formatter.string(from: NSNumber(value: doubleDisplay)) ?? "\(doubleDisplay)"
            
            return formattedString
        }
        
        
        return self
    }
}


extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
