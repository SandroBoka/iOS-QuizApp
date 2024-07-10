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
            
            Form {
                Section(header: Text("Appearance")) {
                    Toggle(isOn: $settingsViewModel.isDarkMode) {
                        Text("Dark Mode")
                            .font(.title3)
                    }
                }
                
                Section(header: Text("Preferences")) {
                    Toggle(isOn: $settingsViewModel.isSoundEffectsEnabled) {
                        Text("Sound Effects")
                            .font(.title3)
                      }
                }
                
                Section(header: Text("Language")) {
                    Picker(selection: $settingsViewModel.selectedLanguage, label: Text("Language").font(.title3)) {
                        ForEach(settingsViewModel.availableLanguages, id: \.self) { language in
                            Text(language).tag(language)
                        }
                    }
                }
            }
            .onChange(of: settingsViewModel.isDarkMode) { oldValue, newValue in
                settingsViewModel.changeColors()
            }
            
            Spacer()
        }
    }
}

struct SettingsView_Preview: PreviewProvider {
    static var previews: some View {
        SettingsView(settingsViewModel: SettingsViewModel(router: Router()))
    }
}
