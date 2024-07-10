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
    @Published var category: String = "Random"
    @Published var difficulty: String = "Any"
    @Published var endData: EndModel = EndModel(numAnswered: 0, numCorrectAnswererd: 0, category: "", difficulty: "")
    @Published var dashEndData: DashEndModel = DashEndModel(numAnswered: 0, numCorrectAnswererd: 0)
    
    enum ViewType {
        case home
        case setup
        case stats
        case normal
        case dash
        case end
        case dashEnd
        case settings
    }
    
    func navigateTo(_ view: ViewType, with transition: AnyTransition = .slide) {
        DispatchQueue.main.async {
            withAnimation {
                self.transition = transition
                self.currentView = view
            }
        }
    }
    
    func navigateWithQuestionsTo(_ view: ViewType, with transition: AnyTransition = .slide, questions: [QuestionModel], category: String, difficulty: String) {
        DispatchQueue.main.async {
            self.data = questions
            self.category = category
            self.difficulty = difficulty
            withAnimation {
                self.transition = transition
                self.currentView = view
            }
        }
    }
    
    func navigateToNormalEnd(_ view: ViewType, with transition: AnyTransition = .slide, endModel: EndModel) {
        DispatchQueue.main.async {
            self.endData = endModel
            withAnimation {
                self.transition = transition
                self.currentView = view
            }
        }
    }
    
    func navigateToDashEnd(_ view: ViewType, with transition: AnyTransition = .slide, dashEndModel: DashEndModel) {
        DispatchQueue.main.async {
            self.dashEndData = dashEndModel
            withAnimation {
                self.transition = transition
                self.currentView = view
            }
        }
    }
}


struct RouterView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            switch router.currentView {
            case .home:
                HomescreenView(homescreenViewModel: HomeScreenViewModel(router: self.router))
                    .transition(router.transition)
            case .setup:
                QuizSetupView(quizSetupViewModel: QuizSetupViewModel(router: self.router))
                    .transition(router.transition)
            case .stats:
                StatsView(statsViewModel: StatsViewModel(router: self.router))
                    .transition(router.transition)
//                StatsView(stats: StatsModel(numAnswered: 679, numCorrect: 480, bestScore: 12, dashNum: 101, normalNum: 78))
//                    .transition(router.transition)
            case .normal:
                QuestionView(questionViewModel: QuestionViewModel(router: self.router, questions: router.data, category: router.category, difficulty: router.difficulty))
                    .transition(router.transition)
            case .dash:
                DashQuestionView(viewModel: DashViewModel(router: self.router))
                    .transition(router.transition)
            case .end:
                EndView(endViewModel: EndViewModel(router: self.router, gameStats: router.endData))
                    .transition(router.transition)
            case .dashEnd:
                DashEndView(dashEndViewModel: DashEndViewModel(router: self.router, gameStats: router.dashEndData))
                    .transition(router.transition)
            case .settings:
                SettingsView(settingsViewModel: SettingsViewModel(router: self.router))
            }
        }
    }
}
