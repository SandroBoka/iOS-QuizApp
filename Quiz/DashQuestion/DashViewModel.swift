//
//  DashViewModel.swift
//  Quiz
//
//  Created by Sandro Boka on 09.07.2024..
//

import Foundation
import Combine
import SwiftUI

class DashViewModel: ObservableObject {
    @Published var currentQuestionIndex = 0
    @Published var selectedAnswer: String?
    @Published var score = 0
    @Published var timeRemaining = 120
    @Published var quizEnded = false
    @Published var questions: [QuestionModel] = []
    
    private var timer: Timer? = nil
    private var cancellables = Set<AnyCancellable>()
    private var router: Router
    
    init(router: Router) {
        self.router = router
        fetchQuestions()
        fetchQuestions()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.2, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timer?.invalidate()
                self.quizEnded = true
                self.goToDashEnd()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    func selectAnswer(_ answer: String) {
        selectedAnswer = answer
        if selectedAnswer == questions[currentQuestionIndex].correctAnswer {
            score += 1
        }
        nextQuestion()
    }
    
    func nextQuestion() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.currentQuestionIndex += 1
            self.selectedAnswer = nil
            
            if self.currentQuestionIndex >= self.questions.count {
                self.quizEnded = true
                self.timer?.invalidate()
            }
        }
    }
    
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func buttonColor(for answer: String) -> Color {
        guard let selectedAnswer = selectedAnswer else { return Color.headerColor }
        
        let isCorrect = answer == questions[currentQuestionIndex].correctAnswer
        if answer == selectedAnswer {
            return isCorrect ? Color.green : Color.red
        } else {
            return Color.gray
        }
    }
    
    func goBack() {
        router.navigateTo(.home)
    }
    
    func goToDashEnd() {
        router.navigateToDashEnd(.dashEnd, dashEndModel: DashEndModel(numAnswered: currentQuestionIndex + 1, numCorrectAnswererd: score))
    }
    
    private func decodeBase64(_ string: String) -> String {
            guard let data = Data(base64Encoded: string),
                  let decodedString = String(data: data, encoding: .utf8) else {
                return "Invalid base64"
            }
            return decodedString
        }
    
    private func fetchQuestions() {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=50&encode=base64") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: QuizResponse.self, decoder: JSONDecoder())
            .map { response in
                response.results.map { quizQuestion in
                    let question = self.decodeBase64(quizQuestion.question)
                    let correctAnswer = self.decodeBase64(quizQuestion.correct_answer)
                    let incorrectAnswers = quizQuestion.incorrect_answers.map { self.decodeBase64($0) }
                    return QuestionModel(
                        question: question,
                        correctAnswer: correctAnswer,
                        incorrectAnswers: incorrectAnswers,
                        allAnswers: Set([correctAnswer] + incorrectAnswers),
                        category: self.decodeBase64(quizQuestion.category)
                    )
                }
            }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] questions in
                self?.questions.append(contentsOf: questions)
            }
            .store(in: &cancellables)
    }
}
