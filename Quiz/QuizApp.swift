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
    let persistenceController = PersistenceController.shared

    init() {
        setupRealmMigration()
    }

    var body: some Scene {
        WindowGroup {
            QuizSetupView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
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
        
       
        print("Realm file path: \(Realm.Configuration.defaultConfiguration.fileURL?.absoluteString ?? "No file URL")")
        
        do {
            _ = try Realm()
        } catch {
            print("Error initializing Realm after migration setup: \(error)")
        }
    } 
}

//tu je izmjenjeno da se moze spojit sa svim skupa
