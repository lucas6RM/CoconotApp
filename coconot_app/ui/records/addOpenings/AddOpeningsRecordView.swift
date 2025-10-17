//
//  AddOpeningsRecordView.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//

import SwiftUI
import Factory

struct AddOpeningsRecordView: View {
    
    @State private var vm = Container.shared.recordsViewModel()
    
    let hotHouse: HotHouseModel
    let weatherManager: WeatherManager
    
    @State private var openWindowTime: Date = Date()
    @State private var closeWindowTime: Date = Date().addingTimeInterval(3600) // +1h par défaut
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                
                // 🌤️ Météo actuelle (comme dans CardHomeComponent)
                VStack(spacing: 12) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(hotHouse.name)
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            if let city = hotHouse.address?.city {
                                Text(city)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        
                        Spacer()
                        VStack(alignment: .center, spacing: 20) {
                            Image(systemName: weatherManager.icon)
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 44))
                                .frame(width: 30, height: 30)
                            
                        }
                        .padding()
                    }
                    HStack (spacing:20){
                        Spacer()
                        Label {
                            Text(weatherManager.temperature)
                                .font(.subheadline)
                        } icon: {
                            Image(systemName: "thermometer.medium")
                        }
                        .labelStyle(.titleAndIcon)
                        .foregroundStyle(.red)
                        
                        Label {
                            Text(weatherManager.humidity)
                                .font(.subheadline)
                        } icon: {
                            Image(systemName: "humidity")
                        }
                        .labelStyle(.titleAndIcon)
                        .foregroundStyle(.blue)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                .shadow(radius: 1, x: 1, y: 1)
                
                
                // 🕓 Sélection des heures d’ouverture et fermeture
                VStack(spacing: 50) {
                    
                    VStack(spacing: 30) {
                        HStack {
                            Image(systemName: "window.open")
                                .foregroundStyle(.blue)
                            Text("Heure d’ouverture :")
                                .font(.subheadline)
                            Spacer()
                        }
                        
                        DatePicker("", selection: $openWindowTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .datePickerStyle(.wheel)
                            .frame(height: 100)
                            .padding(.vertical,20)
                    }
                    
                    VStack(spacing: 30) {
                        HStack {
                            Image(systemName: "window.close")
                                .foregroundStyle(.red)
                            Text("Heure de fermeture :")
                                .font(.subheadline)
                            Spacer()
                        }
                        DatePicker("", selection: $closeWindowTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .datePickerStyle(.wheel)
                            .frame(height: 100)
                            .padding(.vertical,20)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // ✅ Bouton d’enregistrement
                Button {
                    saveOpeningsRecord()
                    
                } label: {
                    Label("Enregistrer", systemImage: "checkmark.circle.fill")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.mint)
                        .foregroundStyle(.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                }
                .padding(.horizontal)
            }
            .padding()
            .navigationTitle("Nouvelle ouverture")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func saveOpeningsRecord() {
            // Formatage des heures en HH:mm
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let openTimeString = formatter.string(from: openWindowTime)
            let closeTimeString = formatter.string(from: closeWindowTime)
            
            let dto = OpenedWindowsDurationDto(
                hotHouseId: hotHouse.id,
                openWindowTime: openTimeString,
                closeWindowTime: closeTimeString
            )
            
            vm.addOpeningsRecord(dto: dto)
            dismiss()
        }
}
