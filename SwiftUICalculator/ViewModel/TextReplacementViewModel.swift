//
//  TextReplacementViewModel.swift
//  SwiftUICalculator
//
//  Created by Jo Cruise on 2024/5/26.
//

import Foundation
import SwiftUI

class TextReplacementViewModel: ObservableObject {
    @Published var items: [String:String] = ["111":"Hello", "123":"hahaha"] {
        didSet {
            saveItems()
        }
    }
    @Published var itemEnabled: [String:Bool] = ["111":true, "123": false]{
        didSet {
            saveEnabledItems()
        }
    }
    @Published var itemFontSize: [String:Int] = ["111":18, "123":15] {
        didSet {
            saveItemFontSize()
        }
    }
    @Published var itemFontWeight: [String:String] = ["111":"Regular", "123":"Bold"] {
        didSet {
            saveItemFontWeight()
        }
    }
    let itemsKey: String = "items_dict"
    let itemEnabledKey: String = "items_enabled_dict"
    let itemFontSizeKey: String = "items_font_size_dict"
    let itemFontWeightKey: String = "items_font_weight_dict"
    
    init() {
        getItems()
        getEnabledItems()
        getItemFontSize()
        getItemFontWeight()
    }
    
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([String:String].self, from: data)
        else { return }
        
        self.items = savedItems
    }
    
    func getEnabledItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemEnabledKey),
            let savedEnabledItems = try? JSONDecoder().decode([String:Bool].self, from: data)
        else { return }
        
        self.itemEnabled = savedEnabledItems
    }
    func getItemFontSize() {
        guard
            let data = UserDefaults.standard.data(forKey: itemFontSizeKey),
            let savedItemFontSize = try? JSONDecoder().decode([String:Int].self, from: data)
        else { return }
        
        self.itemFontSize = savedItemFontSize
    }
    func getItemFontWeight() {
        guard
            let data = UserDefaults.standard.data(forKey: itemFontWeightKey),
            let savedItemFontWeight = try? JSONDecoder().decode([String:String].self, from: data)
        else { return }
        
        self.itemFontWeight = savedItemFontWeight
    }
    
    func deleteItem(indexSet: IndexSet) {
        for index in indexSet {
            let key = Array(items.keys).sorted(by: {$0 < $1})[index]
            items.removeValue(forKey: key)
            itemEnabled.removeValue(forKey: key)
        }
    }
    
//    func moveItem(from: IndexSet, to: Int) {
//        items.move(fromOffsets: from, toOffset: to)
//    }
    
    func addItem(originalText: String, replacingText: String, fontSize: Int, fontWeight: String) {
        items.updateValue(replacingText, forKey: originalText)
        itemEnabled.updateValue(true, forKey: originalText)
        itemFontSize.updateValue(fontSize, forKey: originalText)
        itemFontWeight.updateValue(fontWeight, forKey: originalText)
    }
    
//    func updateItem(item: ItemModel) {
//        
//        if let index = items.firstIndex(where: { $0.id == item.id }) {
//            items[index] = item.updateCompletion()
//        }
//    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
        
    }
    func saveEnabledItems() {
        if let encodedData = try? JSONEncoder().encode(itemEnabled) {
            UserDefaults.standard.set(encodedData, forKey: itemEnabledKey)
        }
    }
    func toggleEnabledItem(key: String) {
        if let value = itemEnabled[key] {
            itemEnabled.updateValue(!value, forKey: key)
        }
    }
    func saveItemFontSize() {
        if let encodedData = try? JSONEncoder().encode(itemFontSize) {
            UserDefaults.standard.set(encodedData, forKey: itemFontSizeKey)
        }
    }
    func saveItemFontWeight() {
        if let encodedData = try? JSONEncoder().encode(itemFontWeight) {
            UserDefaults.standard.set(encodedData, forKey: itemFontWeightKey)
        }
    }
    func convertWeight(weight: String) -> Font.Weight {
        switch weight {
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


