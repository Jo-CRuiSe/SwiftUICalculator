//
//  AddPhraseView.swift
//  SwiftUICalculator
//
//  Created by Jo Cruise on 2024/5/26.
//

import SwiftUI

struct AddPhraseView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: TextReplacementViewModel
    @State var originalText = ""
    @State var replacingText = ""
    @State var fontSize = 95
    @State var fontWeight = "Light"
    @State var title = NSLocalizedString("Add New Phrase", comment: "")
    var body: some View {
        NavigationStack {
            Form {
                Section{
                    HStack {
                        Text("Phrase")
                            .frame(width: 80, alignment: .leading)
                        TextField("", text: $replacingText)
                    }
                    HStack {
                        Text("Shortcut")
                            .frame(width: 80, alignment: .leading)
                        TextField("", text: $originalText)
                        //.keyboardType(.numberPad)
                    }
                    
                } footer: {
                    Text("Create input codes to replace phrases, and you can initiate phrase replacement by shaking your iPhone")
                }
                
                Section {
                    HStack {
                        VStack {
                            Text("Font Size")
                                .font(.subheadline)
                            Picker(selection: $fontSize) {
                                ForEach(45..<150) { number in
                                    Text("\(number)")
                                        .font(.headline)
                                        .tag(number)
                                }
                            } label: {
                                Text("Font Size")
                            }
                            .pickerStyle(.wheel)
                            
                        }
                        VStack {
                            Text("Font Weight")
                                .font(.subheadline)
                            Picker(selection: $fontWeight) {
                                Text("Bold")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .tag("Bold")
                                Text("SemiBold")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .tag("SemiBold")
                                Text("Regular")
                                    .font(.headline)
                                    .fontWeight(.regular)
                                    .tag("Regular")
                                Text("Light")
                                    .font(.headline)
                                    .fontWeight(.light)
                                    .tag("Light")
                                Text("Thin")
                                    .font(.headline)
                                    .fontWeight(.thin)
                                    .tag("Thin")
                            } label: {
                                Text("Font Size")
                            }
                            .pickerStyle(.wheel)
                        }
                    }
                    
                } header: {
                    Text("Font")
                }     
            }
            
            
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        saveButtonPressed()
                    }, label: {
                        Text("Save")
                    })
                    .disabled(originalText == "" || replacingText == "")
                }
            }
        }
    }
    
    func saveButtonPressed() {
        //if textIsAppropriate() {
        listViewModel.addItem(originalText: originalText, replacingText: replacingText, fontSize: fontSize, fontWeight: fontWeight)
        presentationMode.wrappedValue.dismiss()
        //}
    }
}

#Preview {
    AddPhraseView()
        .environmentObject(TextReplacementViewModel())
    
}


