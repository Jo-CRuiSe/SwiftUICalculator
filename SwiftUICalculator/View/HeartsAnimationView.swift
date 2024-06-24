//
//  HeartsAnimationView.swift
//  SwiftUICalculator
//
//  Created by Jo Cruise on 2024/6/3.
//

import SwiftUI

struct HeartsAnimationView: View {
    @State private var animate: Bool = false
    @State private var shouldFeedback: Bool = false
    var beating: Bool = true
    var body: some View {
        Image("RedBeatingHeart")
            .resizable()
            .scaledToFit()
            .frame(width: 300)
            .shadow(
                color: Color.red.opacity(0.7),
                radius: animate ? 30 : 20,
                x: 0,
                y: animate ? 50 : 30
            )
            .scaleEffect(animate ? 1.05 : 1.0)
            .offset(y: animate ? -7 : 0)
            .onAppear{
                addAnimation()
                Timer.scheduledTimer(withTimeInterval: 0.414, repeats: true) { _ in
                    shouldFeedback.toggle()
                }
            }
            .sensoryFeedback(.impact(flexibility: .soft, intensity: 1.3), trigger: shouldFeedback) {oldValue,newValue in
                if beating == true && newValue == true {
                    return true
                } else {
                    return false
                }
            }
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            withAnimation(
                Animation
                    .easeInOut(duration: 0.414)
                    .repeatForever()
            ) {
                animate.toggle()
            }
            
        })
    }
}

#Preview {
    HeartsAnimationView()
}
