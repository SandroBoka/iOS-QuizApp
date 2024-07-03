//
//  QuizMaker.swift
//  Quiz
//
//  Created by Sandro Boka on 03.07.2024..
//

import SwiftUI

struct QuizSetupView: View {
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
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 20)
            
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
            
            // Print the raw data received from the API
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON response: \(jsonString)")
            }
            
            // Optionally, you can decode the response here if you need to use it later
            /*
             do {
             let quizResponse = try JSONDecoder().decode(QuizResponse.self, from: data)
             DispatchQueue.main.async {
             self.questions = quizResponse.results
             alertMessage = "Quiz created successfully with \(questions.count) questions."
             showingAlert = true
             }
             } catch {
             DispatchQueue.main.async {
             alertMessage = "Error decoding data: \(error.localizedDescription)"
             showingAlert = true
             }
             }
             */
        }.resume()
    }
}

struct QuizSetupView_Previews: PreviewProvider {
    static var previews: some View {
        QuizSetupView()
    }
}

