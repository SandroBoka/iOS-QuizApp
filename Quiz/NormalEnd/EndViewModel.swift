//
//  EndViewModel.swift
//  Quiz
//
//  Created by Sandro Boka on 09.07.2024..
//

import Foundation
import RealmSwift

class EndViewModel: ObservableObject {
    @Published var gameStats: EndModel
    private var stats: StatsModelEntity?
    
    private var router: Router
    
    init(router: Router, gameStats: EndModel) {
        self.gameStats = gameStats
        self.router = router
        updateDataBaseForNormalQuiz()
    }
    
    func goToHome() {
        router.navigateTo(.home)
    }
    
    private func updateDataBaseForNormalQuiz() {
            do {
                let realm = try Realm()
                if let statsEntity = realm.objects(StatsModelEntity.self).first {
                    try realm.write {
                        statsEntity.numAnswered += gameStats.numAnswered
                        statsEntity.numCorrect += gameStats.numCorrectAnswererd
                        statsEntity.normalNum += 1
                        
                        stats = statsEntity
                    }
                } else {
                    print("No stats found to increment")
                }
            } catch {
                print("Error updating in Realm: \(error)")
            }
        }
}
