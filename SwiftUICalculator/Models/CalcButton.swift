//
//  CalcButton.swift
//  SwiftUICalculator
//
//  Created by Jo Cruise on 2024/5/10.
//

import Foundation

struct CalcButton: Identifiable, Hashable {
    let id = UUID().uuidString
    let color: CalcColor
    var buttonText: String? = nil
    var action: Action? = nil
    
    static func == (lhs: CalcButton, rhs: CalcButton) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
