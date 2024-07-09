//
//  DashEndView.swift
//  Quiz
//
//  Created by Sandro Boka on 07.07.2024..
//

import Foundation
import SwiftUI

struct DashEndView: View {
    let quizInfo: DashEndModel
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack(spacing: 30) {
            
            HStack {
                Text("Dash Quiz ended")
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
                    Text("Time per question:")
                    Spacer()
                    Text(String(format: "%.1f", (120.0 / Double(quizInfo.numAnswered))) + " seconds")
                        .fontWeight(.bold)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(15)
            
            Spacer()
            
            ExitButton(text: "Exit") {
                router.navigateTo(.home)
            }
            .padding(20)
        }
    }
}

struct DashEndView_Previews: PreviewProvider {
    static var previews: some View {
        
        let stats: DashEndModel = DashEndModel(numAnswered: 16, numCorrectAnswererd: 9)
        
        DashEndView(quizInfo: stats)
    }
}
