//
//  CalcButtonView.swift
//  SwiftUICalculator
//
//  Created by Jo Cruise on 2024/5/10.
//

import SwiftUI

//Code based on https://www.youtube.com/watch?v=GZmubIUjmx4
                                                                                
struct CalcButtonView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @State var isPressed = false
    
    let calcButton: CalcButton
    let action: (() -> ())?
    
    var wide: Bool {
        if let text = calcButton.buttonText {
            return text == "0"
        } else {
            return false
        }
    }
    
    var backgroundColor: Color {
        if let action = calcButton.action,
           action == viewModel.action,
            viewModel.constantlyLit{
            return .white
        }else
        {
            return Color(calcButton.color.rawValue)
        }
    }
    
    var foregroundColor: Color {
        if let action = calcButton.action,
           action == viewModel.action,
           viewModel.constantlyLit
        {
            return Color("CalcOrange")
        } else if calcButton.color == .lightGray {
            return .black
        } else {
            return .white
        }
    }
    
    var body: some View {
        
        Button(action: {
            withAnimation(nil) {
                action?()
            }
            isPressed.toggle()
        }, label: {
            if let text = calcButton.buttonText {
                if text == "AC" {
                    if viewModel.stacked == false {
                        Text(text)
                            .font(.system(size: 35))
                    } else {
                        Text("C")
                            .font(.system(size: 30))
                    }
                    
                } else if text == "%"{
                    Text(text)
                        .font(.system(size: 35))
                } else if text == "." {
                    Text(text)
                        .font(.system(size: 45))
                }
                else {
                    Text(text)
                        .font(.system(size: 40))
                }
            } else if let action = calcButton.action {
                Image(systemName: action.rawValue)
                    .font(.system(size: 30))
                    .fontWeight(.semibold)
            }
        })
        .sensoryFeedback(.impact, trigger: isPressed && settingsViewModel.pressFeedback)
        .buttonStyle(CalcButtonStyle(size: getSize(), backgroundColor: backgroundColor, foregroundColor: foregroundColor, wide: wide))
    }
    
    private func getSize() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let buttonCount: CGFloat = 4
        let spacingCount = buttonCount + 1
        return (screenWidth - (spacingCount * Constants.padding)) / buttonCount
    }
}

#Preview {
    CalcButtonView(calcButton: CalcButton(color: .orange, buttonText: "0", action: nil), action: nil)
}
