//
//  DashQuestionView.swift
//  Quiz
//
//  Created by Sandro Boka on 06.07.2024..
//

import SwiftUI
import Foundation

struct DashQuestionView: View {
    @ObservedObject var dashViewModel: DashViewModel
    
    var body: some View {
        if dashViewModel.questions.isEmpty{
            Text("Loading questions...")
                .font(.title)
                .padding()
        }
        else {
            VStack(spacing: 20) {
                HStack {
                    Button {
                        dashViewModel.goBack()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(Color.black)
                    }
                    Text("Time remaining: \(dashViewModel.timeString(from: dashViewModel.timeRemaining))")
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, minHeight: 70)
                    Spacer()
                }
                .padding(.leading, 10)
                .background {
                    Color.headerColor
                        .ignoresSafeArea()
                }
                
                // Question text and answer buttons
                if !dashViewModel.quizEnded {
                        Text(dashViewModel.questions[dashViewModel.currentQuestionIndex].question)
                            .font(.title)
                            .padding()
                        
                        Divider()
                            .frame(height: 3)
                            .background(Color.gray)
                            .padding()
                        
                        ForEach(Array(dashViewModel.questions[dashViewModel.currentQuestionIndex].allAnswers), id: \.self) { answer in
                            Button(action: {
                                dashViewModel.selectAnswer(answer)
                            }) {
                                Text(answer)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, minHeight: 50)
                                    .background(dashViewModel.buttonColor(for: answer))
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                            }
                            .disabled(dashViewModel.selectedAnswer != nil)
                            .opacity(dashViewModel.selectedAnswer != nil && answer != dashViewModel.selectedAnswer ? 0.5 : 1.0)
                        }
                        
                        Text("Score: \(dashViewModel.score)")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.vertical, 15)
                        
                        Spacer()
                } else {
                    Spacer()
                    Text("Quiz Ended")
                        .font(.title)
                        .padding()
                    Spacer()
                }
            }
            .navigationTitle("Quiz")
            .background(Color.gray.opacity(0.2))
            .onAppear {
                dashViewModel.startTimer()
            }
            .onDisappear {
                dashViewModel.stopTimer()
            }
            .alert(isPresented: $dashViewModel.showAlert) { // Alert for confirmation
                Alert(
                    title: Text("Quit Quiz?"),
                    message: Text("Are you sure you want to quit the quiz?"),
                    primaryButton: .destructive(Text("Quit")) {
                        dashViewModel.confirmGoBack()
                    },
                    secondaryButton: .cancel() {
                        dashViewModel.continueQuiz()
                    }
                )
            }
        }
    }
}

struct DashQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        DashQuestionView(dashViewModel: DashViewModel(router: Router()))
    }
}
