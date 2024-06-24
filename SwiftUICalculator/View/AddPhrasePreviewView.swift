//
//  AddPhrasePreviewView.swift
//  SwiftUICalculator
//
//  Created by 周子航 on 2024/6/23.
//

import SwiftUI

struct AddPhrasePreviewView: View {
    @State var text = "Preview\ndfd"
    @State var widthAlignment = Alignment.trailing
    @State var heightAlignment = Alignment.bottom
    @State var spacing = 10.0
    @State var fontSize = 95
    @State var fontWeight = "Light"
    var body: some View {
        NavigationStack{
            ZStack {
                VStack(spacing: 0){
                    
                    Text(text)
                        .frame(maxWidth: .infinity, alignment: widthAlignment)
                        .frame(maxHeight: .infinity, alignment: heightAlignment)
                        .padding(.bottom, 8)
                        .font(
                            .system(size: CGFloat(fontSize), weight: getFontWeight())
                        )
                        .lineSpacing(spacing)
                        .foregroundStyle(Color.white)
                        .background(Color.black)
                        .lineLimit(5)
                        .minimumScaleFactor(0.5)
                        .padding(.horizontal)
                        .padding(.bottom, 5)
                        
                    
                    HStack(spacing: Constants.padding) {
                        Text("AC")
                            .font(.system(size: 35, weight: .medium))
                            .frame(width: getSize(), height: getSize())
                            .background(Color("CalcLightGray"))
                            .foregroundStyle(.black)
                            .clipShape(Circle())
                        Image(systemName: "plus.forwardslash.minus")
                            .font(.system(size: 30, weight: .medium))
                            .frame(width: getSize(), height: getSize())
                            .background(Color("CalcLightGray"))
                            .foregroundStyle(.black)
                            .clipShape(Circle())
                        Image(systemName: "percent")
                            .font(.system(size: 30, weight: .medium))
                            .frame(width: getSize(), height: getSize())
                            .background(Color("CalcLightGray"))
                            .foregroundStyle(.black)
                            .clipShape(Circle())
                        Image(systemName: "divide")
                            .font(.system(size: 35, weight: .medium))
                            .frame(width: getSize(), height: getSize())
                            .background(Color("CalcOrange"))
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                    }
                    .padding(.bottom, Constants.padding)
                    
                    HStack(spacing:Constants.padding) {
                        Text("7")
                            .font(.system(size: 45, weight: .regular))
                            .frame(width: getSize(), height: getSize())
                            .background(Color("CalcDarkGray"))
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                        Text("8")
                            .font(.system(size: 45, weight: .regular))
                            .frame(width: getSize(), height: getSize())
                            .background(Color("CalcDarkGray"))
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                        Text("9")
                            .font(.system(size: 45, weight: .regular))
                            .frame(width: getSize(), height: getSize())
                            .background(Color("CalcDarkGray"))
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                        Image(systemName: "multiply")
                            .font(.system(size: 35, weight: .medium))
                            .frame(width: getSize(), height: getSize())
                            .background(Color("CalcOrange"))
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                    }
                    .padding(.bottom, Constants.padding)
                    HStack(spacing:Constants.padding) {
                        Text("4")
                            .font(.system(size: 45, weight: .regular))
                            .frame(width: getSize(), height: getSize())
                            .background(Color("CalcDarkGray"))
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                        Text("5")
                            .font(.system(size: 45, weight: .regular))
                            .frame(width: getSize(), height: getSize())
                            .background(Color("CalcDarkGray"))
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                        Text("6")
                            .font(.system(size: 45, weight: .regular))
                            .frame(width: getSize(), height: getSize())
                            .background(Color("CalcDarkGray"))
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                        Image(systemName: "minus")
                            .font(.system(size: 35, weight: .medium))
                            .frame(width: getSize(), height: getSize())
                            .background(Color("CalcOrange"))
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                    }
                    .padding(.bottom, Constants.padding)
                    HStack(spacing:Constants.padding) {
                        Text("1")
                            .font(.system(size: 45, weight: .regular))
                            .frame(width: getSize(), height: getSize())
                            .background(Color("CalcDarkGray"))
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                        Text("2")
                            .font(.system(size: 45, weight: .regular))
                            .frame(width: getSize(), height: getSize())
                            .background(Color("CalcDarkGray"))
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                        Text("3")
                            .font(.system(size: 45, weight: .regular))
                            .frame(width: getSize(), height: getSize())
                            .background(Color("CalcDarkGray"))
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                        Image(systemName: "plus")
                            .font(.system(size: 35, weight: .medium))
                            .frame(width: getSize(), height: getSize())
                            .background(Color("CalcOrange"))
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                    }
                    .padding(.bottom, Constants.padding)
                    HStack(spacing:Constants.padding) {
                        Text("0")
                            .font(.system(size: 45, weight: .regular))
                            .padding(.leading, Constants.padding * 2)
                            .frame(width:2 * getSize() + Constants.padding, height: getSize(),alignment: .leading)
                            .background(Color("CalcDarkGray"))
                            .foregroundStyle(.white)
                            .clipShape(Capsule())
                        
                        Text(".")
                            .font(.system(size: 35, weight: .medium))
                            .frame(width: getSize(), height: getSize())
                            .background(Color("CalcDarkGray"))
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                        Image(systemName: "equal")
                            .font(.system(size: 35, weight: .medium))
                            .frame(width: getSize(), height: getSize())
                            .frame(alignment: .leading)
                            .background(Color("CalcOrange"))
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                    }
                    .padding(.bottom, Constants.padding)
                }
                .padding()
                .padding(.bottom, 5)
                .background(Color.black)
                
                VStack {
                    Text("Preview")
                        .foregroundStyle(.white)
                        .font(.headline)
                    Spacer()
                }
            }
            
        }
    }
    
    private func getSize() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let buttonCount: CGFloat = 4
        let spacingCount = buttonCount + 1
        return (screenWidth - (spacingCount * Constants.padding)) / buttonCount
    }
    
    private func getFontWeight() -> Font.Weight {
        switch fontWeight {
        case "Bold":
            return .bold
        case "SemiBold":
            return .semibold
        case "Regular":
            return .regular
        case "Light":
            return .light
        case "Thin":
            return .thin
        default:
            return .light
        }
    }
}

#Preview {
    NavigationView{
        AddPhrasePreviewView()
    }
}
