//
//  CardDailyReportComponent.swift
//  coconot_app
//
//  Created by lucas mercier on 17/10/2025.
//


import SwiftUI

struct CardDailyReportComponent: View {
    let report: DailyReportModel
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text ("Nom de la serre ()")
                Spacer()
                
                Text("\(report.rateOfTheDay)/5")
                    .foregroundColor(.blue)
            }
            .padding()
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .onTapGesture {
            onTap()
        }
    }
}
