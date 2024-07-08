//
//  Router.swift
//  Quiz
//
//  Created by Sandro Boka on 08.07.2024..
//

import Foundation
import SwiftUI

class Router: ObservableObject {
    @Published var currentView: ViewType = .home
    @Published var transition: AnyTransition = .identity
    
    enum ViewType {
        case home
        case setup
        case stats
    }
    
    func navigateTo(_ view: ViewType, with transition: AnyTransition = .slide) {
        withAnimation {
            self.transition = transition
            currentView = view
        }
    }
    
    func goBack() {
        // Implement your back navigation logic if necessary
    }
}


struct RouterView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            switch router.currentView {
            case .home:
                HomescreenView()
                    .transition(router.transition)
            case .setup:
                QuizSetupView()
                    .transition(router.transition)
            case .stats:
                StatsView(stats: StatsModel(numAnswered: 679, numCorrect: 480, bestScore: 12, dashNum: 101, normalNum: 78))
                    .transition(router.transition)
            }
        }
    }
}
