//
//  QuizMaker.swift
//  Quiz
//
//  Created by Sandro Boka on 03.07.2024..
//

import SwiftUI
import Foundation

struct QuizSetupView: View {
    @EnvironmentObject var router: Router
    
    @State private var numberOfQuestions: Int = 10
    @State private var selectedCategory: Category = .random
    @State private var selectedDifficulty: Difficulty = .medium
    @State private var selectedType: QuestionType = .multipleChoice
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack (spacing: 0){
            HStack {
                Button {
                    print("Back button pressed")
                    router.navigateTo(.home, questions: [])
                } label: {
                    Image(systemName: "chevron.backward")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color.black)
                }
                
                Spacer()
                
                Text("Quiz Setup")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(Color.headerColor)
            
            NavigationView {
                Form {
                    Section(header: Text("Number of Questions")) {
                        Stepper(value: $numberOfQuestions, in: 1...50) {
                            Text("\(numberOfQuestions) Questions")
                        }
                    }
                    
                    Section(header: Text("Category")) {
                        Picker("Select Category", selection: $selectedCategory) {
                            ForEach(Category.allCases) { category in
                                Text(category.rawValue).tag(category)
                            }
                        }
                        .pickerStyle(DefaultPickerStyle())
                    }
                    
                    Section(header: Text("Difficulty")) {
                        Picker("Select Difficulty", selection: $selectedDifficulty) {
                            ForEach(Difficulty.allCases) { difficulty in
                                Text(difficulty.rawValue).tag(difficulty)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Section(header: Text("Question Type")) {
                        Picker("Select Type", selection: $selectedType) {
                            ForEach(QuestionType.allCases) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
            }
            .frame(height: 430)
            .padding(.vertical, 20)
            
            Button(action: {
                createQuiz()
            }) {
                Text("Create Quiz")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.buttonsColor)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        
    }
    
    private func createQuiz() {
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
    
    // relocate to viewModel later
    private func fetchQuiz(from urlString: String) {
        guard let url = URL(string: urlString) else {
            alertMessage = "Invalid URL."
            showingAlert = true
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    alertMessage = "Error: \(error.localizedDescription)"
                    showingAlert = true
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    alertMessage = "No data received."
                    showingAlert = true
                }
                return
            }
            
            // Decode the JSON response
            do {
                let decodedResponse = try JSONDecoder().decode(QuizResponse.self, from: data)
                let questions = decodedResponse.results.map { result in
                    QuestionModel(
                        question: decodeBase64(result.question),
                        correctAnswer: decodeBase64(result.correct_answer),
                        incorrectAnswers: result.incorrect_answers.map { decodeBase64($0) },
                        allAnswers: Set([decodeBase64(result.correct_answer)] + result.incorrect_answers.map { decodeBase64($0) })
                    )
                }
                
                
                // Use the questions array
                print(questions)
                router.navigateTo(.normal, with: .move(edge: .leading), questions: questions)
                
            } catch {
                DispatchQueue.main.async {
                    alertMessage = "Failed to decode JSON: \(error.localizedDescription)"
                    showingAlert = true
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

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        QuizSetupView()
    }
}

