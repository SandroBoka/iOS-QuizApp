//
//  HomescreenView.swift
//  Quiz
//
//  Created by Sandro Boka on 01.07.2024..
//

import SwiftUI

struct HomescreenView: View{
    @ObservedObject var homescreenViewModel: HomeScreenViewModel
    
    var body: some View{
        VStack(spacing: 20) {
            HStack(spacing: 24) {
                Text("Home")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button {
                    homescreenViewModel.goToSettings()
                } label: {
                    Image(systemName: "gearshape")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.black)
                }
            }
                .padding(.vertical, 20)
                .padding(.horizontal, 30)
                .background {
                    Color.headerColor
                        .ignoresSafeArea()
                }
                .padding(.bottom, 10)
            
            CustomButton(text: "Create new Quiz") {
                homescreenViewModel.goToSetup()
            }
            .padding(.vertical, 15)
            
            CustomButton(text: "Dash Mode") {
                homescreenViewModel.goToDash()
            }
            .padding(.bottom, 20)
            
            Divider()
                .frame(height: 3)
                .background(Color.gray)
                .padding(.horizontal, 15)
                .padding(.bottom, 15)
            
            VStack {
                Text("Percentage of Correct Answers: \(homescreenViewModel.percentageCorrect, specifier: "%.1f")%")
                    .font(.headline)
                Text("Best Score in Dash: \(homescreenViewModel.bestDash)")
                    .font(.headline)
            }
            
            CustomButton(text: "More Stats") {
                homescreenViewModel.goToStats()
            }
            .padding(.top, 15)
            
            Spacer()
        }
    }
}

struct CustomButton: View {
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 100)
                .background(Color.buttonsColor)
                .cornerRadius(10)
                .padding(.horizontal)
        }
    }
}

#Preview {
    HomescreenView(homescreenViewModel: HomeScreenViewModel(router: Router()))
}
