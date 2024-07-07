//
//  EndView.swift
//  Quiz
//
//  Created by Sandro Boka on 07.07.2024..
//

import Foundation
import SwiftUI

struct EndView: View {
    let quizInfo: EndModel
    
    var body: some View {
        VStack(spacing: 30) {
            
            HStack {
                Text("Quiz ended")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, minHeight: 70)
            }
            .background {
                Color.headerColor
                    .ignoresSafeArea()
            }
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Summary")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom, 5)
                
                HStack {
                    Text("Number of questions answered:")
                    Spacer()
                    Text("\(quizInfo.numAnswered)")
                        .fontWeight(.bold)
                }
                HStack {
                    Text("Number of correct answers:")
                    Spacer()
                    Text("\(quizInfo.numCorrectAnswererd)")
                        .fontWeight(.bold)
                }
                HStack {
                    Text("Percentage of correct answers:")
                    Spacer()
                    Text(String(format: "%.1f", (Double(quizInfo.numCorrectAnswererd) / Double(quizInfo.numAnswered) * 100)) + "%")
                        .fontWeight(.bold)
                }
                HStack {
                    Text("Category:")
                    Spacer()
                    Text("\(quizInfo.category) ")
                        .fontWeight(.bold)
                }
                HStack {
                    Text("Difficulty:")
                    Spacer()
                    Text("\(quizInfo.difficulty) ")
                        .fontWeight(.bold)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(15)
            
            Spacer()
            
            Button(action: buttonClicked) {
                Text("Exit")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.buttonsColor)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(20)
        }
    }
}

private func buttonClicked() {
    print("Pressed exit")
}

struct EndView_Previews: PreviewProvider {
    static var previews: some View {
        
        let questions: EndModel = EndModel(numAnswered: 25, numCorrectAnswererd: 18, category: "Random", difficulty: "Medium")
        
        EndView(quizInfo: questions)
    }
}
