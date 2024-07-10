//
//  QuizMaker.swift
//  Quiz
//
//  Created by Sandro Boka on 03.07.2024..
//

import SwiftUI
import Foundation

struct QuizSetupView: View {
    @ObservedObject var quizSetupViewModel: QuizSetupViewModel
    var body: some View {
        VStack (spacing: 0){
            HStack {
                Button {
                    quizSetupViewModel.goToHome()
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
                        Stepper(value: $quizSetupViewModel.numberOfQuestions, in: 1...50) {
                            Text("\(quizSetupViewModel.numberOfQuestions) Questions")
                        }
                    }
                    
                    Section(header: Text("Category")) {
                        Picker("Select Category", selection: $quizSetupViewModel.selectedCategory) {
                            ForEach(Category.allCases) { category in
                                Text(category.rawValue).tag(category)
                            }
                        }
                        .pickerStyle(DefaultPickerStyle())
                    }
                    
                    Section(header: Text("Difficulty")) {
                        Picker("Select Difficulty", selection: $quizSetupViewModel.selectedDifficulty) {
                            ForEach(Difficulty.allCases) { difficulty in
                                Text(difficulty.rawValue).tag(difficulty)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Section(header: Text("Question Type")) {
                        Picker("Select Type", selection: $quizSetupViewModel.selectedType) {
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
                quizSetupViewModel.createQuiz()
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
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        QuizSetupView(quizSetupViewModel: QuizSetupViewModel(router: Router()))
    }
}

