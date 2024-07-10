//
//  HomeScreenViewModel.swift
//  Quiz
//
//  Created by Sandro Boka on 09.07.2024..
//

import Foundation

class HomeScreenViewModel: ObservableObject {
    @Published var percentageCorrect: Double = 0
    @Published var bestDash: Int = 0
    
    private var router: Router
    
    init(router: Router) {
        self.router = router
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
}
