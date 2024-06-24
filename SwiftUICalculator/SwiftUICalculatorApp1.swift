//
//  SwiftUICalculatorApp.swift
//  SwiftUICalculator
//
//  Created by Jo Cruise on 2024/5/8.
//

import SwiftUI
import Combine

class AppState: ObservableObject {
    static let shared = AppState()
    @Published var display: String = "0" {
        didSet {
            saveResult()
        }
    }
    
    let displayKey = "AppState_display_key"
    
    func saveResult() {
        if let encodedData = try? JSONEncoder().encode(display) {
            UserDefaults.standard.set(encodedData, forKey: displayKey)
            print("Result saved: \(display)")
        }
    }
    
    func copyDisplayToClipboard() {
        UIPasteboard.general.string = display
    }
}

@main
struct SwiftUICalculatorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var phase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AppState.shared)
        }
        .onChange(of: phase) { oldValue, newValue in
            switch newValue {
            case .active:
                print("App is active")
            case .background:
                print("App went into background")
                AppDelegate().addQuickActions()
            case .inactive:
                print("App is inactive")
                AppDelegate().addQuickActions()
            @unknown default:
                print("default")
            }
        }
    }
}


class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let copyToClipboardKey = "copy_to_clipboard"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        AppState.shared.saveResult()
        addQuickActions()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        AppState.shared.saveResult()
        addQuickActions()
    }
    
    func addQuickActions() {
        UIApplication.shared.shortcutItems = [
            UIApplicationShortcutItem(type: "copy", localizedTitle: "Copy Last Result", localizedSubtitle: AppState.shared.display, icon: UIApplicationShortcutIcon(systemImageName: "doc.on.doc"))
        ]
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        if shortcutItem.type == "copy" {
            AppState.shared.copyDisplayToClipboard()
            print("Copied!")
            //completionHandler(true)
        } else {
            //completionHandler(false)
            print("Didn't Copy")
        }
        print("Didn't Copy")
    }
    
    
}

//class SceneDelegate: UIResponder, UIWindowSceneDelegate, ObservableObject {
//
//    @Published var display: String = "0" {
//        didSet {
//            saveResult()
//        }
//    }
//    
//    func saveResult() {
//        if let encodedData = try? JSONEncoder().encode(display) {
//            UserDefaults.standard.set(encodedData, forKey: SceneDelegate.copyToClipboardKey)
//        }
//    }
//    
//    func copyDisplayToClipBoard() {
//        UIPasteboard.general.string = display
//    }
//    
//    enum ActionType: String {
//        case copyToClipboard = "CopyToClipBoard"
//    }
//    
//    static let copyToClipboardKey = "copy_to_clipboard"
//    
//    var window: UIWindow?
//    var savedShortCutItem: UIApplicationShortcutItem!
//    
//    /// - Tag: willConnectTo
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        /** Process the quick action if the user selected one to launch the app.
//         Grab a reference to the shortcutItem to use in the scene.
//         */
//        if let shortcutItem = connectionOptions.shortcutItem {
//            // Save it off for later when we become active.
//            savedShortCutItem = shortcutItem
//        }
//    }
//    
//    func handleShortCutItem() -> Bool {
//        UIPasteboard.general.string = display
//        return true
//    }
//    
//    /** Called when the user activates your application by selecting a shortcut on the Home Screen,
//     and the window scene is already connected.
//     */
//    /// - Tag: PerformAction
//    func windowScene(_ windowScene: UIWindowScene,
//                     performActionFor shortcutItem: UIApplicationShortcutItem,
//                     completionHandler: @escaping (Bool) -> Void) {
//        let handled = handleShortCutItem()
//        completionHandler(handled)
//    }
//    
//    func sceneDidBecomeActive(_ scene: UIScene) {
//        if savedShortCutItem != nil {
//            _ = handleShortCutItem()
//        }
//        copyDisplayToClipBoard()
//    }
//    /// - Tag: SceneWillResignActive
//    func sceneWillResignActive(_ scene: UIScene) {
//        // Transform each favorite contact into a UIApplicationShortcutItem.
//        let application = UIApplication.shared
//        application.shortcutItems = [UIApplicationShortcutItem(type: ActionType.copyToClipboard.rawValue,
//                                                 localizedTitle: "Copy Last Result",
//                                                 localizedSubtitle: "0",
//                                                 icon: UIApplicationShortcutIcon(systemImageName: "doc.on.doc"))]
//    }
//}


