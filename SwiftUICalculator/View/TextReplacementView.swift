//
//  TextReplacementView.swift
//  SwiftUICalculator
//
//  Created by Jo Cruise on 2024/5/26.
//

import SwiftUI

struct TextReplacementView: View {
    @EnvironmentObject var listviewModel: TextReplacementViewModel
    @State var showSheet: Bool = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(listviewModel.items.keys).sorted(by: { $0 < $1 }), id:\.self) { key in
                    ZStack {
                        HStack{
                            Text(key)
                            Spacer()
                            Text(listviewModel.items[key] ?? "")
                        }
                            
                        NavigationLink {
                            AddPhraseView(originalText: key, replacingText: listviewModel.items[key] ?? "", fontSize: listviewModel.itemFontSize[key] ?? 95, fontWeight: listviewModel.itemFontWeight[key] ?? "Light",  widthAlignment: listviewModel.itemWidthAlignment[key] ?? "trailing", heightAlignment: listviewModel.itemHeightAlignment[key] ?? "bottom", lineSpacing: listviewModel.itemLineSpacing[key] ?? 10.0, title: NSLocalizedString("Change Phrase", comment: ""))
                            
                                
                        } label: {
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 0)
                        .opacity(0)
                        
                    }
                    .swipeActions(edge: .leading) {
                        Button(action: {
                            listviewModel.toggleEnabledItem(key: key)
                        }, label: {
                            Text((listviewModel.itemEnabled[key] ?? false) ? "Disable" : "Enable")
                        })
                        .tint((listviewModel.itemEnabled[key] ?? false) ? Color.gray : Color.blue)
                    }

                }
                .onDelete(perform: listviewModel.deleteItem) 
            }
            
            
            .navigationTitle("Text Replacement")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddPhraseView()
                            .environmentObject(listviewModel)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        
    }
}

#Preview {
    TextReplacementView()
        .environmentObject(TextReplacementViewModel())
}
