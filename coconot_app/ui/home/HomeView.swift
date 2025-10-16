//
//  HomeView.swift
//  PsyBudgetIOS
//
//  Created by lucas mercier on 23/03/2025.
//

import SwiftUI
import Charts
import Factory

struct HomeView: View {
    
    @State private var vm = Container.shared.homeViewModel()
    
    @AppStorage("defaultUserName") var userNameValue = ""
    
    @State private var isSettingsShowed = false
    
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Text("HomeView")
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Bonjour \(userNameValue)!")
                        .font(.headline)
                }
                ToolbarItem (placement: .topBarTrailing){
                        Button("Settings", systemImage: "gearshape", action: {
                            isSettingsShowed = true
                        })
                }
                
            }
            .sheet(
                isPresented: $isSettingsShowed,
                onDismiss: {
                    isSettingsShowed = false
            },
                content: {
                    SettingsView()
                })
            
            
        }
    }
   
}


#Preview {
    HomeView()
}
