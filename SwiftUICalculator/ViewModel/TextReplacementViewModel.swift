//
//  TextReplacementViewModel.swift
//  SwiftUICalculator
//
//  Created by Jo Cruise on 2024/5/26.
//

import Foundation
import SwiftUI

class TextReplacementViewModel: ObservableObject {
    @Published var items: [String:String] = ["111":"This is a demo", "123":"You can change the text to whatever you want"] {
        didSet {
            saveItems()
        }
    }
    @Published var itemEnabled: [String:Bool] = ["111":true, "123": false] {
        didSet {
            saveEnabledItems()
        }
    }
    @Published var itemFontSize: [String:Int] = ["111":70, "123":60] {
        didSet {
            saveItemFontSize()
        }
    }
    @Published var itemFontWeight: [String:String] = ["111":"Regular", "123":"Bold"] {
        didSet {
            saveItemFontWeight()
        }
    }
    @Published var itemWidthAlignment: [String:String] = ["111":"center", "123":"leading"] {
        didSet {
            saveItemWidthAlignment()
        }
    }
    
    @Published var itemHeightAlignment: [String:String] = ["111":"center", "123":"bottom"] {
        didSet {
            saveItemHeightAlignment()
        }
    }
    
    @Published var itemLineSpacing: [String:Float] = ["111": 15.0, "123":10.0] {
        didSet {
            saveItemLineSpacing()
        }
    }
    
    let itemsKey: String = "items_dict"
    let itemEnabledKey: String = "items_enabled_dict"
    let itemFontSizeKey: String = "items_font_size_dict"
    let itemFontWeightKey: String = "items_font_weight_dict"
    let itemWidthAlignmentKey: String = "items_width_alignment_dict"
    let itemHeightAlignmentKey: String = "items_height_alignment_dict"
    let itemLineSpacingKey: String = "items_line_spacing_dict"
    
    init() {
        getItems()
        getEnabledItems()
        getItemFontSize()
        getItemFontWeight()
        getItemWidthAlignment()
        getItemHeightAlignment()
        getItemLineSpacing()
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
    
    func getItemWidthAlignment() {
        guard
            let data = UserDefaults.standard.data(forKey: itemWidthAlignmentKey),
            let savedItemWidthAlignment = try? JSONDecoder().decode([String:String].self, from: data)
        else { return }
        
        self.itemWidthAlignment = savedItemWidthAlignment
    }
    
    func getItemHeightAlignment() {
        guard
            let data = UserDefaults.standard.data(forKey: itemHeightAlignmentKey),
            let savedItemHeightAlignment = try? JSONDecoder().decode([String:String].self, from: data)
        else { return }
        
        self.itemHeightAlignment = savedItemHeightAlignment
    }
    
    func getItemLineSpacing() {
        guard
            let data = UserDefaults.standard.data(forKey: itemLineSpacingKey),
            let savedLineSpacing = try? JSONDecoder().decode([String:Float].self, from: data)
        else { return }
        
        self.itemLineSpacing = savedLineSpacing
    }
    
    func deleteItem(indexSet: IndexSet) {
        for index in indexSet {
            let key = Array(items.keys).sorted(by: {$0 < $1})[index]
            items.removeValue(forKey: key)
            itemEnabled.removeValue(forKey: key)
            itemFontSize.removeValue(forKey: key)
            itemFontWeight.removeValue(forKey: key)
            itemWidthAlignment.removeValue(forKey: key)
            itemHeightAlignment.removeValue(forKey: key)
            itemLineSpacing.removeValue(forKey: key)
        }
    }
    
    func addItem(originalText: String, replacingText: String, fontSize: Int, fontWeight: String, widthAlignment: String, heightAlignment: String, lineSpacing: Float) {
        items.updateValue(replacingText, forKey: originalText)
        itemEnabled.updateValue(true, forKey: originalText)
        itemFontSize.updateValue(fontSize, forKey: originalText)
        itemFontWeight.updateValue(fontWeight, forKey: originalText)
        itemWidthAlignment.updateValue(widthAlignment, forKey: originalText)
        itemHeightAlignment.updateValue(heightAlignment, forKey: originalText)
        itemLineSpacing.updateValue(lineSpacing, forKey: originalText)
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
    func saveItemWidthAlignment() {
        if let encodedData = try? JSONEncoder().encode(itemWidthAlignment) {
            UserDefaults.standard.set(encodedData, forKey: itemWidthAlignmentKey)
        }
    }
    func saveItemHeightAlignment() {
        if let encodedData = try? JSONEncoder().encode(itemHeightAlignment) {
            UserDefaults.standard.set(encodedData, forKey: itemHeightAlignmentKey)
        }
    }
    func saveItemLineSpacing() {
        if let encodedData = try? JSONEncoder().encode(itemLineSpacing) {
            UserDefaults.standard.set(encodedData, forKey: itemLineSpacingKey)
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
    func convertAlignment(alignment: String) -> Alignment {
        switch alignment {
        case "leading":
            return .leading
        case "center":
            return .center
        case "trailing":
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


