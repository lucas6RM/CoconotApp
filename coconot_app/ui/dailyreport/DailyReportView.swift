//
//  DailyReportView.swift
//  coconot_app
//
//  Created by lucas mercier on 17/10/2025.
//

import SwiftUI
import Factory

struct DailyReportView: View {
    @Environment(\.dismiss) private var dismiss
    
    
    @State private var vm = Container.shared.dailyReportViewModel()
    
    let report: DailyReportModel
    @State private var userRating: Int = 0
    
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                Text("Rapport \(report.hotHouseId)")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.top)
            
            Form {
                // Températures
                Section("Températures") {
                    ForEach(report.temperatureMeasurements) { t in
                        HStack {
                            Text("Relevé à \(convertTimeStampToString(date: t.timestamp))")
                            Spacer()
                            Text("\(t.temperatureMeasuredInsideHotHouse, specifier: "%.1f")°C")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                // Humidité
                Section("Humidité") {
                    ForEach(report.humidityMeasurements) { h in
                        HStack {
                            Text("Relevé à \(convertTimeStampToString(date: h.timestamp))")
                            Spacer()
                            Text("\(h.humidityMeasuredInsideHotHouse, specifier: "%.0f")%")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                // Ouvertures
                Section("Ouvertures") {
                    if report.openedWindowsDurations.isEmpty {
                        Text("Aucune ouverture enregistrée")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(report.openedWindowsDurations) { o in
                            HStack {
                                Spacer()
                                Text("\(o.openWindowTime) - \(o.closeWindowTime)")
                                Spacer()
                            }
                        }
                    }
                }
                
                // Note du jour
                Section("Note du jour") {
                    VStack(spacing: 8) {
                        Text("Évaluez la journée")
                            .font(.subheadline)
                        HStack(spacing: 4) {
                            ForEach(1...5, id: \.self) { star in
                                Image(systemName: star <= userRating ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                                    .onTapGesture { userRating = star }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 4)
                }
            }
            .formStyle(.grouped)
            
            Button {
                print("submit rapport")
                dismiss()
            } label: {
                Text("Envoyer évalutation")
            }
            .disabled(false)
            .buttonStyle(.borderedProminent)
            .shadow(radius: 0.5, y:0.5)
            .padding(20)

        }
        .task {
            vm.getHotHouseById(id: report.hotHouseId)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func convertTimeStampToString(date: Date) -> String {
        date.formatted(date: .omitted, time: .shortened)
    }
}

