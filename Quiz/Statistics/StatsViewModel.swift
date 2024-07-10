//
//  StatsViewModel.swift
//  Quiz
//
//  Created by Sandro Boka on 10.07.2024..
//

import Foundation
import RealmSwift
import SwiftUI

class StatsViewModel: ObservableObject {
    @Published var stats: StatsModelEntity = StatsModelEntity()
    @Published var didGetData = false
    
    private var router: Router
    
    init(router: Router) {
        self.router = router
        fetchStats()
    }
    
    func goBack() {
        router.navigateTo(.home)
    }
    
    func fetchStats() {
        do {
            let realm = try Realm()
            if let statsEntity = realm.objects(StatsModelEntity.self).first {
                self.stats = statsEntity
                self.didGetData = true
            } else {
                print("Database empty")
            }
        } catch {
            print("Error initializing Realm: \(error)")
        }
    }
    
    func clearDatabase() {
        do {
            let realm = try Realm()
            if let statsEntity = realm.objects(StatsModelEntity.self).first {
                try realm.write {
                    statsEntity.numAnswered = 0
                    statsEntity.numCorrect = 0
                    statsEntity.bestScore = 0
                    statsEntity.dashNum = 0
                    statsEntity.normalNum = 0
                    self.stats = statsEntity
                }
            } else {
                print("No stats found to clear")
            }
        } catch {
            print("Error clearing database in Realm: \(error)")
        }
    }
}

