//
//  Injection+Storage.swift
//  PsyBudgetLocal
//
//  Created by lucas mercier on 13/05/2025.
//

import Factory
import SwiftData
import Foundation

extension Container {

    @MainActor
    var homeViewModel: Factory<HomeView.ViewModel> {
        self {
            @MainActor in
            HomeView.ViewModel(
            )
        }
    }
    
    @MainActor
    var hotHouseViewModel: Factory<HotHouseView.ViewModel> {
        self {
            @MainActor in
            HotHouseView.ViewModel(
                
            )
        }
    }
    
    @MainActor
    var dailyReportViewModel: Factory<DailyReportView.ViewModel> {
        self {
            @MainActor in
            DailyReportView.ViewModel(
                
            )
        }
    }
}
