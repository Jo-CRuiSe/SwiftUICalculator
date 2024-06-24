//
//  SettingsView.swift
//  SwiftUICalculator
//
//  Created by Jo Cruise on 2024/5/26.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel:ContentViewModel
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @State var changePasscode = false
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text(settingsViewModel.tiggerPasscode)
                    Button(action: {
                        changePasscode = true
                    }, label: {
                        Text("Change Passcode")
                    })
                } header: {
                    Text("Tigger Passcode")
                } footer: {
                    Text("This number is used to enter Settings")
                }
                
                Section {
                    NavigationLink {
                        TextReplacementView()
                    } label: {
                        Text("Text Replacement")
                    }
                }
                
//                Section {
//                    Stepper(value: $settingsViewModel.minimumScaleFactor, in: (0.1)...1, step: 0.1) {
//                        Text("\(settingsViewModel.minimumScaleFactor.formatted(.number))")
//                    }
//                    .sensoryFeedback(.impact, trigger: settingsViewModel.minimumScaleFactor) { _, _ in
//                        settingsViewModel.pressFeedback == true
//                    }
//                    
//                } header: {
//                    Text("Minimum Scale Factor")
//                } footer: {
//                    Text("The minimum ratio to which the text will automatically shrink")
//                }
                
//                Section {
//                    Picker(selection: $settingsViewModel.lineLimit) {
//                        ForEach(1..<5) { number in
//                            Text("\(number)")
//                                .font(.headline)
//                                .tag(number)
//                        }
//                    } label: {
//                        Text("Line Limit")
//                    }
//                    .pickerStyle(.menu)
//                } footer: {
//                    Text("Maximum number of lines for character display")
//                }
                
                Section {
                    Slider(value: $settingsViewModel.birthRate, in: 1...10, minimumValueLabel: Text(""), maximumValueLabel: Text(String(format: "%.1f", settingsViewModel.birthRate)), label: {
                        Text("\($settingsViewModel.birthRate)")
                    })
                } header: {
                    Text("Sprites Birth Rate")
                } footer: {
                    Text("The larger the value, the higher the sprites generation rate")
                }
                
                Section {
                    Slider(value: $settingsViewModel.emissionDuration, in: 3...15, minimumValueLabel: Text(""), maximumValueLabel: Text(String(format: "%.1f", settingsViewModel.emissionDuration)), label: {
                        Text("\($settingsViewModel.emissionDuration)")
                    })
                } header: {
                    Text("Sprites Emitter Duration")
                } footer: {
                    Text("The larger the value, the longer the emission duration")
                }
                
                Section {
                    Toggle(isOn: $settingsViewModel.pressFeedback, label: {
                        Text("Haptic Feedback")
                    })
                    .onReceive(settingsViewModel.$pressFeedback, perform: { _ in
                        UserDefaults.standard.set(settingsViewModel.pressFeedback, forKey: "pressFeedback")
                    })
                    .sensoryFeedback(.impact, trigger: settingsViewModel.pressFeedback)
                    
                }
                
                
                Link("About the Developer", destination: URL(string: "https://jo-cruise.github.io/about/")!)
                
                
                
                
                
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $changePasscode, content: {
                ChangePasscodeView()
                
            })
        }
    }
    
}

#Preview {
    SettingsView()
        .environmentObject(SettingsViewModel())
        .environmentObject(ContentViewModel())
    //    ChangePasscodeView()
    //        .environmentObject(SettingsViewModel())
}

struct ChangePasscodeView: View {
    @State var newPasscode = ""
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @State var alertTitle = ""
    @State var showAlert = false
    @FocusState var isFocused: Bool
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Change your passcode")
                
                TextField("", text: $newPasscode)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
                    .frame(height: 70)
                    .background(.ultraThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .keyboardType(.decimalPad)
                    .focused($isFocused)
                    .onAppear {
                        isFocused = true
                        newPasscode = settingsViewModel.tiggerPasscode
                    }
                
            }
            .navigationTitle("Change Passcode")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        if checkValidity() {
                            settingsViewModel.tiggerPasscode = newPasscode
                            settingsViewModel.savePasscode()
                            dismiss()
                        }
                    }, label: {
                        Text("Save")
                    })
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
                
            }
            .alert(alertTitle, isPresented: $showAlert) {
                
            }
        }
        
        .toolbar(.visible, for: .automatic)
        
    }
    
    func checkValidity() -> Bool {
        if newPasscode.count < 2 {
            alertTitle = "Passcode should be longer than 2 numbers!"
            showAlert = true
            return false
        } else if newPasscode.rangeOfCharacter(from: CharacterSet.letters) != nil {
            alertTitle = "Please only enter numbers!"
            showAlert = true
            return false
        }
        return true
    }
}

