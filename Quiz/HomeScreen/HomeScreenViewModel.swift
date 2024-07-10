//
//  HomeScreenViewModel.swift
//  Quiz
//
//  Created by Sandro Boka on 09.07.2024..
//

import Foundation
import RealmSwift

class HomeScreenViewModel: ObservableObject {
    @Published var percentageCorrect: Double = 0
    @Published var bestDash: Int = 0
    @Published var stats: StatsModelEntity = StatsModelEntity()
    
    private var router: Router
    
    init(router: Router) {
        self.router = router
        readFromDatabase()
    }
    
    func goToSetup() {
        router.navigateTo(.setup, with: .move(edge: .trailing))
    }
    
    func goToDash() {
        router.navigateTo(.dash, with: .move(edge: .trailing))
    }
    
    func goToStats() {
        router.navigateTo(.stats, with: .move(edge: .trailing))
    }
    
    func readFromDatabase() {
        do {
            let realm = try Realm()
            if let statsEntity = realm.objects(StatsModelEntity.self).first {
                self.stats = statsEntity
                self.percentageCorrect = Double(stats.numCorrect) / Double(stats.numAnswered) * 100
                self.bestDash = stats.bestScore
            } else {
                print("Database empty")
            }
        } catch {
            print("Error initializing Realm: \(error)")
        }
    }
}
