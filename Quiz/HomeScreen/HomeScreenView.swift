//
//  HomescreenView.swift
//  Quiz
//
//  Created by Sandro Boka on 01.07.2024..
//

import SwiftUI

extension Color {
    static let headerColor = Color(red:0/255, green: 128/255, blue: 129/255)//tirkizna tamnija
    static let backgroundColor = Color(red:255/255, green: 255/255, blue: 221/255)// bijelo zuta
    static let buttonsColor = Color(red:21/255, green: 205/255, blue: 150/255)//svjetlo zelena
    
    static let headerColorDark = Color(red: 107/255, green: 89/255, blue: 205/255)//ljubicasta
    static let backgroundColorDark  = Color(red:20/255, green: 20/255, blue: 41/255)//crna ljubicasta
    static let buttonsColorDark  = Color(red:198/255, green: 180/255, blue: 216/255)//svjetlo ljubicasta
     
}

struct HomescreenView: View{
    @ObservedObject var homescreenViewModel: HomeScreenViewModel
    
    var body: some View{
        VStack(spacing: 20) {
            header
                .padding(.vertical, 20)
                .padding(.horizontal, 30)
                .foregroundStyle(.white)
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

private var header: some View{
    HStack(spacing: 24) {
        Text("Home")
            .font(.title2)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
        
        Button {
            print("Settings button pressed")
        } label: {
            Image(systemName: "gearshape")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
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
