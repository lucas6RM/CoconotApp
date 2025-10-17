//
//  AddTemperatureRecordView.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//

import SwiftUI
import Factory

struct AddTemperatureRecordView: View {
    
    @State private var vm = Container.shared.recordsViewModel()
    
    let hotHouse: HotHouseModel
    let weatherManager: WeatherManager
    
    @State private var selectedTemperature: Int = 20
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
                            
                            Label {
                                Text(weatherManager.temperature)
                                    .font(.subheadline)
                            } icon: {
                                Image(systemName: "thermometer.medium")
                            }
                            .labelStyle(.titleAndIcon)
                            .foregroundStyle(.red)
                        }
                        .padding()
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                .shadow(radius: 1, x: 1, y: 1)
                
                // 🌡️ Sélection de la température à enregistrer
                VStack(spacing: 16) {
                    Text("Température à enregistrer")
                        .font(.headline)
                    
                    Picker("Température", selection: $selectedTemperature) {
                        ForEach(-10..<51) { value in
                            Text("\(value) °C")
                                .tag(value)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                    
                    Text("Valeur sélectionnée : \(selectedTemperature)°C")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal)
                
                Spacer()
                
                // ✅ Bouton d’enregistrement
                Button {
                    saveTemperatureRecord()
                } label: {
                    Label("Enregistrer", systemImage: "checkmark.circle.fill")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundStyle(.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                }
                .padding(.horizontal)
            }
            .padding()
            .navigationTitle("Nouvelle mesure température")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func saveTemperatureRecord() {
            guard let weatherTemp = Double(weatherManager.temperature.replacingOccurrences(of: "°C", with: "")) else {
                print("Erreur parsing température météo")
                return
            }
            
            let dto = TemperatureMeasureDto(
                hotHouseId: hotHouse.id,
                temperatureMeasuredInsideHotHouse: Double(selectedTemperature),
                temperatureFromWeather: weatherTemp,
            )
            
            vm.addTemperatureRecord(dto: dto)
            dismiss()
        }
}
