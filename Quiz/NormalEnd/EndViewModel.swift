//
//  EndViewModel.swift
//  Quiz
//
//  Created by Sandro Boka on 09.07.2024..
//

import Foundation

class EndViewModel: ObservableObject {
    @Published var gameStats: EndModel
    
    private var router: Router
    
    init(router: Router, gameStats: EndModel) {
        self.gameStats = gameStats
        self.router = router
    }
    
    func goToHome() {
        router.navigateTo(.home)
    }
}
