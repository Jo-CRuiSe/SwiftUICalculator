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
    @State var widthAlignment = "trailing"
    @State var heightAlignment = "bottom"
    @State var textAlignment = TextAlignment.leading
    @State var lineSpacing: Float = 10.0
    @State var title = NSLocalizedString("Add New Phrase", comment: "")
    @State var savedSuccessfully = false
    @State var showPopover = false
    @State var placeholderText = NSLocalizedString("Phrase", comment: "")
    let screenWidth = UIScreen.main.bounds.width
    let buttonCount: CGFloat = 4
    let spacingCount = 5
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section{
                    HStack {
                        TextField("", text: $originalText, prompt: Text("Shortcut"))
                            .padding(.leading, 3)
                    }
                    HStack {
                        ZStack(alignment: .leading) {
                            if replacingText.isEmpty {
                               TextEditor(text: $placeholderText)
                                    .foregroundStyle(.secondary).opacity(0.5)
                                    .disabled(true)
                                
                            }
                            TextEditor(text: $replacingText)
                        }
                        .lineLimit(2)
                    }
                } footer: {
                    Text("Create input codes to replace phrases, and you can initiate phrase replacement by shaking your iPhone, supporting multi-line input")
                }

                
                //                NavigationLink {
                //                    AddPhrasePreviewView(text: replacingText, widthAlignment: getAlignment(alignment: widthAlignment), heightAlignment: getAlignment(alignment: heightAlignment), spacing: spacing,fontSize: fontSize, fontWeight: fontWeight)
                //                } label: {
                //                    Text("Preview")
                //                }
                //
                
                Section {
                    VStack {
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
                        
                        Picker("", selection: $widthAlignment, content: {
                            Image(systemName: "text.alignleft")
                                .tag("leading")
                            Image(systemName: "text.aligncenter")
                                .tag("center")
                            Image(systemName: "text.alignright")
                                .tag("trailing")
                        })
                        .pickerStyle(.segmented)
                        .formStyle(.columns)
                        .sensoryFeedback(.impact, trigger: widthAlignment)
                        
                        Picker("", selection: $heightAlignment, content: {
                            Image(systemName: "arrow.up.to.line.compact")
                                .tag("top")
                            Image(systemName: "arrow.down.and.line.horizontal.and.arrow.up")
                                .tag("center")
                            Image(systemName: "arrow.down.to.line.compact")
                                .tag("bottom")
                        })
                        .pickerStyle(.segmented)
                        .formStyle(.columns)
                        .sensoryFeedback(.impact, trigger: heightAlignment)
                        
                        HStack {
                            Spacer()
                            Stepper(value: $lineSpacing, in: 1...40, step: 1) {
                                HStack{
                                    Text("Line Spacing")
                                    Spacer()
                                    
                                    Text("\(lineSpacing.formatted(.number))")
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(.ultraThickMaterial)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .onTapGesture {
                                            showPopover.toggle()
                                        }
                                        .popover(isPresented: $showPopover ,content: {
                                            HStack {
                                                Slider(value: $lineSpacing, in: 1...40,step: 1, label: {
                                                    
                                                })
                                                .padding(.horizontal, 20)
                                            }
                                            .padding(.horizontal)
                                            .frame(width: 300)
                                            .presentationCompactAdaptation(.popover)
                                        })
                                }
                            }
                            .sensoryFeedback(.impact, trigger: lineSpacing)
                        }
                    }
                } header: {
                    Text("Style")
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
                    .sensoryFeedback(.success, trigger: savedSuccessfully)
                    
                }
            }
        }
        
    }
    
    func saveButtonPressed() {
        //if textIsAppropriate() {
        listViewModel.addItem(originalText: originalText, replacingText: replacingText, fontSize: fontSize, fontWeight: fontWeight, widthAlignment: widthAlignment, heightAlignment: heightAlignment, lineSpacing: lineSpacing)
        presentationMode.wrappedValue.dismiss()
        savedSuccessfully = true
        print(widthAlignment)
        //}
    }
    
    private func getAlignment(alignment: String) -> Alignment {
        switch alignment {
        case "leading":
            textAlignment = .leading
            return .leading
        case "center":
            textAlignment = .center
            return .center
        case "trailing":
            textAlignment = .trailing
            return .trailing
        case "top":
            return .top
        case "bottom":
            return .bottom
        default:
            return .trailing
        }
    }
}

#Preview {
    AddPhraseView()
        .environmentObject(TextReplacementViewModel())
    
}


