//
//  HomeView.swift
//  PsyBudgetIOS
//
//  Created by lucas mercier on 23/03/2025.
//

import SwiftUI
import Charts
import Factory

struct DailyReportView: View {
    
    @State private var vm = Container.shared.dailyReportViewModel()
    
    var body: some View {
        VStack {
            Text("DailyReportView")
        }
    }
}
