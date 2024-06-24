//
//  ListRowView.swift
//  SwiftUICalculator
//
//  Created by Jo Cruise on 2024/5/26.
//

import SwiftUI

struct ListRowView: View {
    let item: ItemModel
    
    var body: some View {
        
        HStack {
            
            Text(item.originalText)
                .foregroundStyle(.primary)
            Spacer()
            Text(item.replacingText)
                .foregroundStyle(.secondary)
            
            
        }
        
        
    }
}

var item1 = ItemModel(originalText: "111", replacingText: "Hello")

#Preview {
    ListRowView(item: item1)
}
