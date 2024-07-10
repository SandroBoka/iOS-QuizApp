//
//  QuizSetupViewModel.swift
//  Quiz
//
//  Created by Sandro Boka on 10.07.2024..
//

import Foundation
import SwiftUI

class QuizSetupViewModel: ObservableObject {
    @Published var numberOfQuestions: Int = 10
    @Published var selectedCategory: Category = .random
    @Published var selectedDifficulty: Difficulty = .medium
    @Published var selectedType: QuestionType = .multipleChoice

    @Published var showingAlert = false
    @Published var alertMessage = ""

    private var router: Router
    private var questions: [QuestionModel] = []
    
    init(router: Router) {
        self.router = router
    }
    
    func goToHome() {
        router.navigateTo(.home)
    }
    
    func goToNormalQuiz() {
        router.navigateWithQuestionsTo(.normal, with: .move(edge: .trailing), questions: self.questions, category: self.selectedCategory.rawValue, difficulty: self.selectedDifficulty.rawValue)
    }
    
    func createQuiz() {
        var urlCall = "https://opentdb.com/api.php?"
        
        urlCall += "amount=\(numberOfQuestions)"
        
        if selectedCategory != .random, let categoryID = categoryDictionary[selectedCategory] {
            urlCall += "&category=\(categoryID)"
        }
        
        if selectedDifficulty != .any {
            urlCall += "&difficulty=\(selectedDifficulty)"
        }
        
        if selectedType != .any, let typeID = typeDictionary[selectedType]{
            urlCall += "&type=\(typeID)"
        }
        
        urlCall += "&encode=base64"
        
        print(urlCall)
        
        fetchQuiz(from: urlCall)
    }
    
    private func fetchQuiz(from urlString: String) {
        guard let url = URL(string: urlString) else {
            alertMessage = "Invalid URL."
            showingAlert = true
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.alertMessage = "Error: \(error.localizedDescription)"
                    self.showingAlert = true
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.alertMessage = "No data received."
                    self.showingAlert = true
                }
                return
            }
            
            // Decode the JSON response
            do {
                let decodedResponse = try JSONDecoder().decode(QuizResponse.self, from: data)
                self.questions = decodedResponse.results.map { result in
                    QuestionModel(
                        question: self.decodeBase64(result.question),
                        correctAnswer: self.decodeBase64(result.correct_answer),
                        incorrectAnswers: result.incorrect_answers.map { self.decodeBase64($0) },
                        allAnswers: Set([self.decodeBase64(result.correct_answer)] +  result.incorrect_answers.map { self.decodeBase64($0) }),
                        category: self.decodeBase64(result.category)
                    )
                }
                
                DispatchQueue.main.async {
                    self.goToNormalQuiz()
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.alertMessage = "Failed to decode JSON: \(error.localizedDescription)"
                    self.showingAlert = true
                }
            }
            
        }.resume()
    }
    
    private func decodeBase64(_ string: String) -> String {
        guard let data = Data(base64Encoded: string),
              let decodedString = String(data: data, encoding: .utf8) else {
            return "Invalid base64"
        }
        return decodedString
    }
}

