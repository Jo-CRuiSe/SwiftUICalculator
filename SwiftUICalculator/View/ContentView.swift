//
//  ContentView.swift
//  SwiftUICalculator
//
//  Created by Jo Cruise on 2024/5/8.
//

import SwiftUI
import SpriteKit
import TipKit

enum buttonType: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case clear
    case positive_minus
    case percent
    case divide
    case mutiply
    case subtract
    case plus
    case equal
    case decimal
}

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @StateObject var listviewModel = TextReplacementViewModel()
    @StateObject var settingsViewModel = SettingsViewModel()
    @State var isShaked = false
    @State var isLongPressed = false
    @State var birthdayCakeScene = BirthdayCakeRain()
    @State var snowingScene = SparklesRain()
    @State var floatingScene = Floating()
    @State var fontSize = 95
    @State var fontWeight = "Light"
    @State var showBeatingHeart = false
    
    
    var tiggerDict = ShakeText.tiggerDict
    var body: some View {
        NavigationStack{
            ZStack {
                VStack(spacing: 0) {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        Text(
                            listviewModel.items.values.contains(viewModel.display) ? viewModel.display : viewModel.display.formatString()
                        )
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .padding(.bottom, 5)
                        .font(
                            //.system(size: 95.0, weight: Font.Weight.light)
                            viewModel.ACPressed ? .system(size: 95.0, weight: .light) : .system(size: CGFloat(fontSize), weight: listviewModel.convertWeight(weight: fontWeight))
                        )
                        .foregroundStyle(Color.white)
                        .background(Color.black)
                        .lineLimit(listviewModel.items.values.contains(viewModel.display) ? settingsViewModel.lineLimit : 1)
                        .minimumScaleFactor(listviewModel.items.values.contains(viewModel.display) ? settingsViewModel.minimumScaleFactor : 0.5)
                        .onLongPressGesture {
                            if viewModel.display == settingsViewModel.tiggerPasscode {
                                isLongPressed.toggle()
                            }
                        }
                        .gesture(
                            DragGesture()
                                .onEnded { _ in
                                    viewModel.userSwiped()
                                }
                        )
                        .onShake {
                            if
                                let value =  listviewModel.items[viewModel.display],
                                let enabled = listviewModel.itemEnabled[viewModel.display],
                                let font_size = listviewModel.itemFontSize[viewModel.display],
                                let font_weight = listviewModel.itemFontWeight[viewModel.display],
                                enabled == true {
                                fontSize = font_size
                                fontWeight = font_weight
                                viewModel.display = value
                                viewModel.canDeleteLastDigit = false
                                viewModel.ACPressed = false
                                isShaked.toggle()
                                if value.contains("🎂") {
                                    snowingScene.node.particleBirthRate = settingsViewModel.birthRate
                                    snowingScene.node.particleTexture = SKTexture(imageNamed: "BirthdayCake")
                                } else if value.contains("🥰") {
                                    snowingScene.node.particleBirthRate = settingsViewModel.birthRate
                                    snowingScene.node.particleTexture = SKTexture(imageNamed: "SmilingHeart")
                                } else if value.contains("😘") {
                                    snowingScene.node.particleBirthRate = settingsViewModel.birthRate
                                    snowingScene.node.particleTexture = SKTexture(imageNamed: "BlowingKiss")
                                } else if value.contains("🥳") {
                                    snowingScene.node.particleBirthRate = settingsViewModel.birthRate
                                    snowingScene.node.particleTexture = SKTexture(imageNamed: "Partying")
                                } else if value.contains("✨") {
                                    snowingScene.node.particleBirthRate = settingsViewModel.birthRate
                                    snowingScene.node.particleTexture = SKTexture(imageNamed: "Sparkles")
                                } else if value.contains("❤️") || value.contains("🫰") ||  value.contains("🫶") {
                                    snowingScene.node.particleBirthRate = settingsViewModel.birthRate
                                    snowingScene.node.particleTexture = SKTexture(imageNamed: "RedHeart")
                                } else if value.contains("💓") {
                                    showBeatingHeart = true
                                } else if value.contains("💕") {
                                    floatingScene.node.particleBirthRate = settingsViewModel.birthRate
                                }
                                
                                
                                Timer.scheduledTimer(withTimeInterval: settingsViewModel.emissionDuration, repeats: false) { _ in
                                    birthdayCakeScene.node.particleBirthRate = 0.0
                                    snowingScene.node.particleBirthRate = 0.0
                                    floatingScene.node.particleBirthRate = 0.0
                                }
                                Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
                                    showBeatingHeart = false
                                }
                            }
                        }
                        .onAppear{
                            settingsViewModel.pressFeedback = UserDefaults.standard.bool(forKey: "pressFeedback")
                        }
                        .sensoryFeedback(.impact, trigger: isShaked) { oldValue, newValue in
                            settingsViewModel.pressFeedback == true
                        }
                        .sensoryFeedback(.impact, trigger: isLongPressed) { oldValue, newValue in
                            settingsViewModel.pressFeedback == true
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                    
                    
                    ForEach(Constants.calcButtons, id: \.self) { row in
                        HStack(spacing: Constants.padding) {
                            ForEach(row, id: \.id) { button in
                                CalcButtonView(calcButton: button) {
                                    viewModel.buttonPressed(button)
                                }
                            }
                        }
                        
                        .padding(.bottom, Constants.padding)
                    }
                    
                }
                
                .padding()
                .padding(.bottom, 5)
                .background(Color.black)
                .navigationDestination(isPresented: $isLongPressed, destination: {
                    SettingsView()
                })
                
                //                SpriteView(scene: birthdayCakeScene, options: [.allowsTransparency])
                //                    .ignoresSafeArea()
                //                    .allowsHitTesting(false)
                //                SpriteView(scene: blowingKissScene, options: [.allowsTransparency])
                //                    .ignoresSafeArea()
                //                    .allowsHitTesting(false)
                //                SpriteView(scene: partyingScene, options: [.allowsTransparency])
                //                    .ignoresSafeArea()
                //                    .allowsHitTesting(false)
                //                SpriteView(scene: smilingHeartScene, options: [.allowsTransparency])
                //                    .ignoresSafeArea()
                //                    .allowsHitTesting(false)
                //                SpriteView(scene: sparklesScene, options: [.allowsTransparency])
                //                    .ignoresSafeArea()
                //                    .allowsHitTesting(false)
//                SpriteView(scene: flowersScene, options: [.allowsTransparency])
//                    .ignoresSafeArea()
//                    .allowsHitTesting(false)
                SpriteView(scene: snowingScene, options: [.allowsTransparency])
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
                SpriteView(scene: floatingScene, options: [.allowsTransparency])
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
                HeartsAnimationView(beating: showBeatingHeart)
                    .ignoresSafeArea()
                    .opacity(showBeatingHeart ? 1 : 0)
                    .animation(.smooth, value: showBeatingHeart)
                    //.allowsHitTesting(false)
                
            }
            
            
        }
        .environmentObject(viewModel)
        .environmentObject(listviewModel)
        .environmentObject(settingsViewModel)
        
        
        
        
    }
}


#Preview {
    ContentView()
    //        .environment(\.local, .init(identifier: "zh-Hans"))
}

