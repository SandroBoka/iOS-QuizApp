//
//  SettingsView.swift
//  Quiz
//
//  Created by Sandro Boka on 10.07.2024..
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @ObservedObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    settingsViewModel.goBack()
                } label: {
                    Image(systemName: "chevron.backward")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color.black)
                }
                
                Spacer()
                
                Text("Settings     ")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(Color.headerColor)
            
            Toggle(isOn: $settingsViewModel.isDarkMode) {
                            Text("Dark Mode")
                                .font(.title3)
                        }
                        .padding(30)
            
            Spacer()
        }
        .onChange(of: settingsViewModel.isDarkMode) { oldValue, newValue in
            settingsViewModel.changeColors()
        }
    }
}

struct SettingsView_Preview: PreviewProvider {
    static var previews: some View {
        SettingsView(settingsViewModel: SettingsViewModel(router: Router()))
    }
}
