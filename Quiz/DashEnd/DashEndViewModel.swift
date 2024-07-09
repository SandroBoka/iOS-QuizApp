//
//  DashEndViewModel.swift
//  Quiz
//
//  Created by Sandro Boka on 09.07.2024..
//

import Foundation

class DashEndViewModel: ObservableObject {
    @Published var gameStats: DashEndModel
    
    private var router: Router
    
    init(router: Router, gameStats: DashEndModel) {
        self.gameStats = gameStats
        self.router = router
    }
    
    func goToHome() {
        router.navigateTo(.home)
    }
}
