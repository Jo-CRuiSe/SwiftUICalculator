//
//  ItemModel.swift
//  SwiftUICalculator
//
//  Created by Jo Cruise on 2024/5/26.
//

import Foundation
struct ItemModel:Identifiable, Codable {
    let id: String
    let originalText: String
    //let isCompleted: Bool
    let replacingText: String
    
    init(id: String = UUID().uuidString, originalText: String, replacingText: String) {
        self.id = id
        self.originalText = originalText
        self.replacingText = replacingText
    }
    
//    func updateCompletion() -> ItemModel {
//        return ItemModel(id: id, tittle: originalText, isCompleted: !isCompleted)
//    }
}
