//
//  SettingsView.swift
//  PsyBudgetLocal
//
//  Created by lucas mercier on 10/09/2025.
//

import SwiftUI

struct SettingsView: View {
    
    
    @AppStorage("isDarkModeEnabled") var isDarkMode = false
    @AppStorage("defaultUserName") var defaultUserNameValue = ""
    
    
    @State private var userName: String
    
    
    @Environment(\.dismiss) private var dismiss
    
    
    init() {
        self._userName = State(initialValue: UserDefaults.standard.string(forKey: "defaultUserName") ?? "")
    }
    
    var body: some View {
        
        VStack{
            
            HStack {
                Spacer()
                Text("Réglages")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                
                Toggle("Mode Nuit", isOn: $isDarkMode)
                    .toggleStyle(.button)
                    .padding()
                
            }
            
            Form {
                
                Section("Nom utilisateur",content: {
                    TextField("Nom utilisateur", text: $userName)
                        .multilineTextAlignment(.center)
                })
                
                
            }.preferredColorScheme(isDarkMode ? .dark : .light)
            
            Button("Modifier"){
                
                defaultUserNameValue = userName
                dismiss()
            }
            .disabled(false)
            .buttonStyle(.borderedProminent)
            .shadow(radius: 0.5, y:0.5)
            .padding(20)
        }
    }
}

