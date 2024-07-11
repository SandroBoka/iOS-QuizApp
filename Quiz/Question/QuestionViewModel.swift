//
//  QuestionViewModel.swift
//  Quiz
//
//  Created by Sandro Boka on 09.07.2024..
//

import Foundation
import Combine
import SwiftUI

class QuestionViewModel: ObservableObject {
    @Published var currentQuestionIndex = 0
    @Published var selectedAnswer: String?
    @Published var showNextButton = false
    @Published var questions: [QuestionModel] = []
    @Published var showAlert = false  // New property for alert display
    
    private var router: Router
    private var numCorrectAnswered = 0
    private var category: String
    private var difficulty: String
    
    init(router: Router, questions: [QuestionModel], category: String, difficulty: String) {
        self.router = router
        self.questions = questions
        self.category = category
        self.difficulty = difficulty
    }
    
    
    func selectAnswer(_ answer: String) {
        selectedAnswer = answer
        showNextButton = true
        
        // Increment numCorrectAnswered if the selected answer is correct
        if answer == questions[currentQuestionIndex].correctAnswer {
            numCorrectAnswered += 1
        }
    }
    
    func nextQuestion() {
        if currentQuestionIndex >= questions.count - 1 {
            // Quiz completed logic
            self.goToEnd()
        } else {
            currentQuestionIndex += 1
            selectedAnswer = nil
            showNextButton = false
        }
    }
    
    func buttonColor(for answer: String) -> Color {
        guard let selectedAnswer = selectedAnswer else { return Color.headerColor }
        
        let isCorrect = answer == questions[currentQuestionIndex].correctAnswer
        return answer == selectedAnswer ? (isCorrect ? Color.green : Color.red) : Color.gray
    }
    
    func goBack() {
        showAlert = true  // Show alert instead of navigating back
    }
    
    func confirmGoBack() {
        router.navigateTo(.home)  // Actual navigation
    }
    
    func goToEnd() {
        router.navigateToNormalEnd(.end, with: .opacity, endModel: EndModel(numAnswered: questions.count, numCorrectAnswererd: numCorrectAnswered, category: category, difficulty: difficulty))
    }
}
