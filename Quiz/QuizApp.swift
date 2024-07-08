//
//  QuizApp.swift
//  Quiz
//
//  Created by Sandro Boka on 01.07.2024..
//

import SwiftUI

@main
struct QuizApp: App {
    
    @StateObject private var router = Router()
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            RouterView()
                .environmentObject(router)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
