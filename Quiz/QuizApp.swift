//
//  QuizApp.swift
//  Quiz
//
//  Created by Sandro Boka on 01.07.2024..
//

import SwiftUI
import RealmSwift

@main
struct QuizApp: SwiftUI.App {
    @StateObject private var router = Router()
    let persistenceController = PersistenceController.shared

    init() {
        setupRealmMigration()
        RealmManager.shared.initializeRealm()
    }
    
    var body: some Scene {
        WindowGroup {
            RouterView()
                .environmentObject(router)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    applyDarkModeSetting()
                }
        }
    }

    private func setupRealmMigration() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    
                    migration.enumerateObjects(ofType: StatsModelEntity.className()) { oldObject, newObject in
                        
                        newObject!["id"] = ObjectId.generate()
                    }
                }
            }
        )
        
        Realm.Configuration.defaultConfiguration = config
        
        do {
            _ = try Realm()
        } catch {
            print("Error initializing Realm after migration setup: \(error)")
        }
    }
    
    private func applyDarkModeSetting() {
            let isDarkMode = RealmManager.shared.fetchDarkModeSetting()
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                windowScene.windows.forEach { window in
                    window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
                }
            }
        }
}
