//
//  DashQuestionView.swift
//  Quiz
//
//  Created by Sandro Boka on 06.07.2024..
//

import SwiftUI
import Foundation

struct DashQuestionView: View {
    @ObservedObject var viewModel: DashViewModel
    
    var body: some View {
        if viewModel.questions.isEmpty{
            Text("Loading questions...")
                .font(.title)
                .padding()
        }
        else {
            VStack(spacing: 20) {
                HStack {
                    Button {
                        viewModel.goBack()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(Color.black)
                    }
                    Text("Time remaining: \(viewModel.timeString(from: viewModel.timeRemaining))")
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
                if !viewModel.quizEnded {
                        Text(viewModel.questions[viewModel.currentQuestionIndex].question)
                            .font(.title)
                            .padding()
                        
                        Divider()
                            .frame(height: 3)
                            .background(Color.gray)
                            .padding()
                        
                        ForEach(Array(viewModel.questions[viewModel.currentQuestionIndex].allAnswers), id: \.self) { answer in
                            Button(action: {
                                viewModel.selectAnswer(answer)
                            }) {
                                Text(answer)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, minHeight: 50)
                                    .background(viewModel.buttonColor(for: answer))
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                            }
                            .disabled(viewModel.selectedAnswer != nil)
                            .opacity(viewModel.selectedAnswer != nil && answer != viewModel.selectedAnswer ? 0.5 : 1.0)
                        }
                        
                        Text("Score: \(viewModel.score)")
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
                viewModel.startTimer()
            }
            .onDisappear {
                viewModel.stopTimer()
            }
        }
    }
}

struct DashQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        DashQuestionView(viewModel: DashViewModel(router: Router()))
    }
}
