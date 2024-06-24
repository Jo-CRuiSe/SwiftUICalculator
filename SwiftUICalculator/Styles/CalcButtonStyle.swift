//
//  CalcButtonStyle.swift
//  SwiftUICalculator
//
//  Created by Jo Cruise on 2024/5/10.
//

import SwiftUI

struct CalcButtonStyle: ButtonStyle {
    let size: CGFloat
    let backgroundColor: Color
    let foregroundColor: Color
    var wide: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 30, weight: .medium))
            .frame(width: size, height: size)
            .frame(maxWidth: wide ? .infinity : size, alignment: .leading)
            .background(backgroundColor)
            .foregroundStyle(foregroundColor)
            .overlay {
                if configuration.isPressed {
                    Color(white: 1.0, opacity: 0.25)
                }
            }
            .clipShape(Capsule())
    }
}

#Preview(body: {
    Button {
        
    } label: {
        Text("0")
    }
    .buttonStyle(CalcButtonStyle(size: 50.0, backgroundColor: .orange, foregroundColor: .white))
})
