//
//  DashQuestionView.swift
//  Quiz
//
//  Created by Sandro Boka on 06.07.2024..
//

import SwiftUI
import Foundation

struct DashQuestionView: View {
    let questions: [QuestionModel]
    
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: String?
    @State private var showNextButton = false
    
    @State private var timeRemaining = 120 // 2 minutes in seconds
    @State private var timer: Timer? = nil
    @State private var quizEnded = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack {
                Text("Time remaining: \(timeString(from: timeRemaining))")
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, minHeight: 70)
            }
            .background {
                Color.headerColor
                    .ignoresSafeArea()
            }
            
            // Question text and answer buttons
            if !quizEnded {
                Text(questions[currentQuestionIndex].question)
                    .font(.title)
                    .padding()
                
                Divider()
                    .frame(height: 3)
                    .background(Color.gray)
                    .padding()
                
                ForEach(Array(questions[currentQuestionIndex].allAnswers), id: \.self) { answer in
                    Button(action: {
                        selectAnswer(answer)
                        print("Selected answer: \(answer)")
                    }) {
                        Text(answer)
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(buttonColor(for: answer))
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .disabled(selectedAnswer != nil) // Disable buttons after selection
                    .opacity(selectedAnswer != nil && answer != selectedAnswer ? 0.5 : 1.0) // Dim other answers when one is selected
                }
                
                Spacer()
                
                // Next question button
                if showNextButton {
                    Button(action: nextQuestion) {
                        Text("Next Question")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.orange.opacity(0.7))
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .padding(.bottom)
                }
            } else {
                Text("Quiz Ended")
                    .font(.title)
                    .padding()
            }
        }
        .navigationTitle("Quiz")
        .background(Color.gray.opacity(0.2))
        .onAppear {
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private func selectAnswer(_ answer: String) {
        selectedAnswer = answer
        showNextButton = true
    }
    
    private func nextQuestion() {
        currentQuestionIndex += 1
        selectedAnswer = nil
        showNextButton = false
        
        if currentQuestionIndex >= questions.count {
            // Quiz completed logic can go here
            print("Quiz completed!")
            currentQuestionIndex = 0 // Reset the quiz
        }
    }
    
    private func buttonColor(for answer: String) -> Color {
        guard let selectedAnswer = selectedAnswer else { return Color.headerColor }
        
        let isCorrect = answer == questions[currentQuestionIndex].correctAnswer
        if answer == selectedAnswer {
            return isCorrect ? Color.green : Color.red
        } else {
            return Color.gray
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timer?.invalidate()
                self.quizEnded = true
            }
        }
    }
    
    private func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct DashQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        
        let questions: [Quiz.QuestionModel] = [
            Quiz.QuestionModel(
                question: "Who succeeded Joseph Stalin as General Secretary of the Communist Party of the Soviet Union?",
                correctAnswer: "Nikita Khrushchev",
                incorrectAnswers: ["Leonid Brezhnev", "Mikhail Gorbachev", "Boris Yeltsin"],
                allAnswers: ["Nikita Khrushchev", "Boris Yeltsin", "Leonid Brezhnev", "Mikhail Gorbachev"]
            ),
            Quiz.QuestionModel(
                question: "GoldenEye 007 on the Nintendo 64 was planned to allow you to play as all previous Bond actors, with the exception of who?",
                correctAnswer: "George Lazenby",
                incorrectAnswers: ["Roger Moore", "Sean Connery", "Timothy Dalton"],
                allAnswers: ["Timothy Dalton", "Sean Connery", "George Lazenby", "Roger Moore"]
            ),
            Quiz.QuestionModel(
                question: "How many countries border Kyrgyzstan?",
                correctAnswer: "4",
                incorrectAnswers: ["3", "1", "6"],
                allAnswers: ["6", "4", "3", "1"]
            ),
            Quiz.QuestionModel(
                question: "What is the name of the protagonist of J.D. Salinger's novel Catcher in the Rye?",
                correctAnswer: "Holden Caulfield",
                incorrectAnswers: ["Fletcher Christian", "Jay Gatsby", "Randall Flagg"],
                allAnswers: ["Jay Gatsby", "Holden Caulfield", "Randall Flagg", "Fletcher Christian"]
            ),
            Quiz.QuestionModel(
                question: "What is the most populous Muslim-majority nation in 2010?",
                correctAnswer: "Indonesia",
                incorrectAnswers: ["Saudi Arabia", "Iran", "Sudan"],
                allAnswers: ["Indonesia", "Sudan", "Saudi Arabia", "Iran"]
            ),
            Quiz.QuestionModel(
                question: "After how many years would you celebrate your crystal anniversary?",
                correctAnswer: "15",
                incorrectAnswers: ["20", "10", "25"],
                allAnswers: ["15", "20", "10", "25"]
            ),
            Quiz.QuestionModel(
                question: "What is the scientific term for 'taste'?",
                correctAnswer: "Gustatory Perception",
                incorrectAnswers: ["Olfaction", "Somatosensation", "Auditory Perception"],
                allAnswers: ["Auditory Perception", "Olfaction", "Gustatory Perception", "Somatosensation"]
            ),
            Quiz.QuestionModel(
                question: "Which of these is not a world in the anime 'Buddyfight'?",
                correctAnswer: "Ancient Dragon World",
                incorrectAnswers: ["Dragon World", "Star Dragon World", "Darkness Dragon World"],
                allAnswers: ["Star Dragon World", "Ancient Dragon World", "Dragon World", "Darkness Dragon World"]
            ),
            Quiz.QuestionModel(
                question: "Which album by American rapper Kanye West contained songs such as 'Love Lockdown', 'Paranoid' and 'Heartless'?",
                correctAnswer: "808s & Heartbreak",
                incorrectAnswers: ["Late Registration", "The Life of Pablo", "Graduation"],
                allAnswers: ["Graduation", "808s & Heartbreak", "Late Registration", "The Life of Pablo"]
            ),
            Quiz.QuestionModel(
                question: "In association football, or soccer, a corner kick is when the game restarts after someone scores a goal.",
                correctAnswer: "False",
                incorrectAnswers: ["True"],
                allAnswers: ["False", "True"]
            )
        ]
        
        DashQuestionView(questions: questions)
    }
}
