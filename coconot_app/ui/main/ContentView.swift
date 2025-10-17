//
//  ContentView.swift
//  PsyBudgetIOS
//
//  Created by lucas mercier on 22/03/2025.
//

import SwiftUI

enum TabSelection {
    case home, hothouse, dailyReport
}

struct ContentView: View {
    
    @State private var selectedDate : Date = Date()
    @State private var tabSelection : TabSelection = .home
    
    var body: some View {
        TabView(selection: $tabSelection) {
            
            HomeView()
                .tabItem {
                    Label("Accueil", systemImage: "house.fill")
                }
                .tag(TabSelection.home)
            
            HotHouseView()
                .tabItem {
                    Label("Serres", systemImage: "rainbow")
                }
                .tag(TabSelection.hothouse)
            
            AllDailyReportView()
                .tabItem {
                    Label("Rapports", systemImage: "chart.line.text.clipboard")
                }
                .tag(TabSelection.dailyReport)
            
            
            
        }.onChange(of: tabSelection) { _ , _ in
            selectedDate = Date()
        }
    }
}

#Preview {
    ContentView()
    
}
