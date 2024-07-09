//
//  DashEndView.swift
//  Quiz
//
//  Created by Sandro Boka on 07.07.2024..
//

import Foundation
import SwiftUI

struct DashEndView: View {
    
    @ObservedObject var dashEndViewModel: DashEndViewModel
    
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
                    Text("\(dashEndViewModel.gameStats.numAnswered)")
                        .fontWeight(.bold)
                }
                HStack {
                    Text("Number of correct answers:")
                    Spacer()
                    Text("\(dashEndViewModel.gameStats.numCorrectAnswererd)")
                        .fontWeight(.bold)
                }
                HStack {
                    Text("Percentage of correct answers:")
                    Spacer()
                    Text(String(format: "%.1f", (Double(dashEndViewModel.gameStats.numCorrectAnswererd) / Double(dashEndViewModel.gameStats.numAnswered) * 100)) + "%")
                        .fontWeight(.bold)
                }
                HStack {
                    Text("Time per question:")
                    Spacer()
                    Text(String(format: "%.1f", (120.0 / Double(dashEndViewModel.gameStats.numAnswered))) + " seconds")
                        .fontWeight(.bold)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(15)
            
            Spacer()
            
            ExitButton(text: "Exit") {
                dashEndViewModel.goToHome()
            }
            .padding(20)
        }
    }
}

struct DashEndView_Previews: PreviewProvider {
    static var previews: some View {
        
        let stats: DashEndModel = DashEndModel(numAnswered: 16, numCorrectAnswererd: 9)
        
        DashEndView(dashEndViewModel: DashEndViewModel(router: Router(), gameStats: stats))
    }
}
