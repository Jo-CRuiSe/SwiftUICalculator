//
//  SwiftUICalculatorApp.swift
//  SwiftUICalculator
//
//  Created by Jo Cruise on 2024/5/8.
//

import SwiftUI
import Combine

class AppState: ObservableObject {
    @Published var display: String = "0" {
        didSet {
            saveResult()
        }
    }
    
    init() {
        getResult()
    }
    
    let displayKey = "AppState_display_key"
    
    func saveResult() {
        if display == "+∞" || display == "NaN" || display == "-∞" {
            display = NSLocalizedString("Error", comment: "")
        }
        if let encodedData = try? JSONEncoder().encode(display) {
            UserDefaults.standard.set(encodedData, forKey: displayKey)
            print("Result saved: \(display)")
        }
    }
    
    func getResult() {
        guard
            let data = UserDefaults.standard.data(forKey: displayKey),
            let savedDisplay = try? JSONDecoder().decode(String.self, from: data)
        else { return }
        
        self.display = savedDisplay
    }
    
    func copyDisplayToClipboard() {
        UIPasteboard.general.string = display
        print("Copied to Clipboard")
    }

}

@main
struct SwiftUICalculatorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var phase
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
        .onChange(of: phase) { oldValue, newValue in
            switch newValue {
            case .active:
                print("App is active")
                if QuickAction.selectedAction?.type is String{
                    appState.copyDisplayToClipboard()
                }
            case .background:
                print("App went into background")
            case .inactive:
                print("App is inactive")
                appState.saveResult()
                UIApplication.shared.shortcutItems = [UIApplicationShortcutItem(type: "copy", localizedTitle: NSLocalizedString("Copy Last Result", comment: ""), localizedSubtitle: appState.display, icon: UIApplicationShortcutIcon(systemImageName: "doc.on.doc"))]
            @unknown default:
                print("default")
            }
        }
    }
}

enum QuickAction {
    static var selectedAction: UIApplicationShortcutItem?
    
    static var allShortcutItems = [
        UIApplicationShortcutItem(type: "copy", localizedTitle: NSLocalizedString("Copy Last Result", comment: ""), localizedSubtitle: "0", icon: UIApplicationShortcutIcon(systemImageName: "doc.on.doc"))
    ]
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let appState = AppState()
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        //UIApplication.shared.shortcutItems = [UIApplicationShortcutItem(type: "copy", localizedTitle: "Copy Last Result", localizedSubtitle: appState.display, icon: UIApplicationShortcutIcon(systemImageName: "doc.on.doc"))]
        
        if let selectedAction = options.shortcutItem {
            QuickAction.selectedAction = selectedAction
        }
        let sceneConfiguration = UISceneConfiguration(name: "Quick Action Scene", sessionRole: connectingSceneSession.role)
        sceneConfiguration.delegateClass = QuickActionSceneDelegate.self
        return sceneConfiguration
    }
}

class QuickActionSceneDelegate: UIResponder, UIWindowSceneDelegate {
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        QuickAction.selectedAction = shortcutItem
    }
}

