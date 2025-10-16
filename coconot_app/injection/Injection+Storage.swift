//
//  Injection+Storage.swift
//  PsyBudgetLocal
//
//  Created by lucas mercier on 13/05/2025.
//

import Factory
import Foundation

extension Container {

    
    var apiService: Factory<ApiService> {
        self {
            ApiService()
        }.singleton
    }
    
    
    @MainActor
    var globalRepository: Factory<GlobalRepository> {
        self {
            @MainActor in
            GlobalRepository(apiService: self.apiService())
        }.singleton
    }
    
    
    
    @MainActor
    var homeViewModel: Factory<HomeView.ViewModel> {
        self {
            @MainActor in
            HomeView.ViewModel(globalRepository: self.globalRepository())
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
