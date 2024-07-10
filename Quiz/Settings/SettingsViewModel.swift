//
//  SettingsViewModel.swift
//  Quiz
//
//  Created by Sandro Boka on 10.07.2024..
//

import Foundation
import UIKit

class SettingsViewModel: ObservableObject {
    @Published var isDarkMode: Bool {
            didSet {
                // Save the dark mode setting
                UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
            }
        }
    @Published var isSoundEffectsEnabled: Bool = false
    @Published var selectedLanguage: String = "English"
    @Published var availableLanguages: [String] = ["English", "Croatian", "German"]
    private var router: Router
    
    init(router: Router) {
        self.router = router
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    }
    
    func goBack() {
        router.navigateTo(.home)
    }
    
    func changeColors() {
        // Update the app's appearance
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.forEach { window in
                window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
            }
        }
    }
}
