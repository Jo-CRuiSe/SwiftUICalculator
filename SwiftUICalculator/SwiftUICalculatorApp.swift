//
//  SwiftUICalculatorApp.swift
//  SwiftUICalculator
//
//  Created by Jo Cruise on 2024/5/8.
//

import SwiftUI

@main
struct SwiftUICalculatorApp: App {
    @Environment(\.scenePhase) var phase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: phase) { oldValue, newValue in
            switch newValue {
            case .background, .inactive:
                setupQuickAction()
            case .active:
                print("active")
                //setupQuickAction()
            @unknown default:
                print("default")
                //setupQuickAction()
            }
        }
    }
    
    func setupQuickAction() {
        UIApplication.shared.shortcutItems = [
            UIApplicationShortcutItem(type: NSLocalizedString("Copy Last Result", comment: ""), localizedTitle: NSLocalizedString("Copy Last Result", comment: ""), localizedSubtitle: "0", icon: UIApplicationShortcutIcon(systemImageName: "doc.on.doc"))
        ]
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: "Custom Configuration", sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = CustomSceneDelegate.self
        return sceneConfig
    }
}

class CustomSceneDelegate: UIResponder, UIWindowSceneDelegate {
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        print(shortcutItem.userInfo as Any)
    }
}
