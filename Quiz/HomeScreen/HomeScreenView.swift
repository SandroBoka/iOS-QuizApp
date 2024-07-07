//
//  HomescreenView.swift
//  Quiz
//
//  Created by Sandro Boka on 01.07.2024..
//

import SwiftUI

extension Color {
    static let headerColor = Color(red: 64/255, green: 165/255, blue: 120/255)
    static let backgroundColor = Color(red:255/255, green: 255/255, blue: 221/255)
    static let buttonsColor = Color(red:21/255, green: 205/255, blue: 150/255)
}

struct HomescreenView: View{
    
    @State private var percentageCorrect: Double = 85.0
    @State private var bestDash: Int = 6
    
    var body: some View{
        VStack(spacing: 20) {
            header
                .padding(.vertical, 20)
                .padding(.horizontal, 30)
                .foregroundStyle(.black)
                .background {
                    Color.headerColor
                        .ignoresSafeArea()
                }
                .padding(.bottom, 10)
            
            CustomButton(text: "Create new Quiz") {
                print("Create new Quiz pressed.")
            }
            .padding(.vertical, 15)
            
            CustomButton(text: "Dash Mode") {
                print("Dash Mod pressed.")
            }
            .padding(.bottom, 20)
            
            Divider()
                .frame(height: 3)
                .background(Color.gray)
                .padding(.horizontal, 15)
                .padding(.bottom, 15)
            
            VStack {
                Text("Percentage of Correct Answers: \(percentageCorrect, specifier: "%.1f")%")
                    .font(.headline)
                Text("Best Score in Dash: \(bestDash)")
                    .font(.headline)
            }
            
            CustomButton(text: "More Stats") {
                print("More Stats pressed.")
            }
            .padding(.top, 15)
            
            Spacer()
        }
        .background(Color.backgroundColor.opacity(0.4))
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
    HomescreenView()
}
