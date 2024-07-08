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
    @Published var data: [QuestionModel] = []
    
    enum ViewType {
        case home
        case setup
        case stats
        case normal
    }
    
    func navigateTo(_ view: ViewType, with transition: AnyTransition = .slide) {
        DispatchQueue.main.async {
            withAnimation {
                self.transition = transition
                self.currentView = view
            }
        }
    }
    
    func navigateWithQuestionsTo(_ view: ViewType, with transition: AnyTransition = .slide, questions data: [QuestionModel]) {
        DispatchQueue.main.async {
            self.data = data
            withAnimation {
                self.transition = transition
                self.currentView = view
            }
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
                
            case .normal:
                QuestionView(questions: router.data)
                    .transition(router.transition)
            }
        }
    }
}
