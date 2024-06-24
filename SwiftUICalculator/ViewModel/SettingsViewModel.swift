//
//  SettingsViewModel.swift
//  SwiftUICalculator
//
//  Created by Jo Cruise on 2024/5/26.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var tiggerPasscode = "12345"
    @Published var minimumScaleFactor = 0.5 {
        didSet {
            saveMinimumScaleFactor()
        }
    }
    @Published var lineLimit = 2 {
        didSet {
            saveLineLimit()
        }
    }
    @Published var birthRate = 4.0 {
        didSet {
            saveBirthRate()
        }
    }
    @Published var emissionDuration = 5.0 {
        didSet {
            saveEmissionDuration()
        }
    }
    
    @Published var pressFeedback: Bool = true
    @Published var alertTitle = ""
    @Published var showAlert = false
    
    init() {
        getPasscode()
        getMinimumScaleFactor()
        getLineLimit()
        getBirthRate()
        getEmissionDuration()
    }
    
    let passcodeKey: String = "passcode"
    let minimumScaleFactorKey: String = "minimumScaleFactor"
    let lineLimitKey: String = "lineLimit"
    let birthRateKey: String = "birthRate"
    let emissionDurationKey: String = "emissionDuration"
    
    private func getPasscode() {
        guard
            let passcode = UserDefaults.standard.data(forKey: passcodeKey),
            let savedPasscode = try? JSONDecoder().decode(String.self, from: passcode)
        else { return }
        
        self.tiggerPasscode = savedPasscode
    }
    
    func savePasscode() {
        if let encodedData = try? JSONEncoder().encode(tiggerPasscode) {
            UserDefaults.standard.set(encodedData, forKey: passcodeKey)
        }
    }
    
    private func getMinimumScaleFactor() {
        guard
            let minimumScaleFactor = UserDefaults.standard.data(forKey: minimumScaleFactorKey),
            let savedMinimumScaleFactor = try? JSONDecoder().decode(Double.self, from: minimumScaleFactor)
        else { return }
        
        self.minimumScaleFactor = savedMinimumScaleFactor
    }
    
    func saveMinimumScaleFactor() {
        if let encodedData = try? JSONEncoder().encode(minimumScaleFactor) {
            UserDefaults.standard.set(encodedData, forKey: minimumScaleFactorKey)
        }
    }
    
    private func getLineLimit() {
        guard
            let lineLimit = UserDefaults.standard.data(forKey: lineLimitKey),
            let savedLineLimit = try? JSONDecoder().decode(Int.self, from: lineLimit)
        else { return }
        
        self.lineLimit = savedLineLimit
    }
    
    func saveLineLimit() {
        if let encodedData = try? JSONEncoder().encode(lineLimit) {
            UserDefaults.standard.set(encodedData, forKey: lineLimitKey)
        }
    }
    
    private func getBirthRate() {
        guard
            let birthRate = UserDefaults.standard.data(forKey: birthRateKey),
            let savedBirthRate = try? JSONDecoder().decode(Double.self, from: birthRate)
        else { return }
        
        self.birthRate = savedBirthRate
    }
    
    private func saveBirthRate() {
        if let encodedData = try? JSONEncoder().encode(birthRate) {
            UserDefaults.standard.set(encodedData, forKey: birthRateKey)
        }
    }
    
    private func getEmissionDuration() {
        guard
            let emissionDuration = UserDefaults.standard.data(forKey: emissionDurationKey),
            let savedEmissionDuration = try? JSONDecoder().decode(Double.self, from: emissionDuration)
        else { return }
        
        self.emissionDuration = savedEmissionDuration
    }
    
    private func saveEmissionDuration() {
        if let encodedData = try? JSONEncoder().encode(emissionDuration) {
            UserDefaults.standard.set(encodedData, forKey: emissionDurationKey)
        }
    }
}
