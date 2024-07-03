//
//  QuizApp.swift
//  Quiz
//
//  Created by Sandro Boka on 01.07.2024..
//

import SwiftUI

@main
struct QuizApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            QuizSetupView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
