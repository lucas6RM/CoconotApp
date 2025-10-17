//
//  AddHumidityRecordView.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//

import SwiftUI
import Factory

struct AddHumidityRecordView: View {
    
    
    @State private var vm = Container.shared.recordsViewModel()
    
    let hotHouse: HotHouseModel
    let weatherManager: WeatherManager
    
    @State private var selectedHumidity: Int = 50
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
                        VStack(alignment: .center, spacing: 20){
                            
                            Image(systemName: weatherManager.icon)
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 44))
                                .frame(width: 30, height: 30)
                            
                            Label {
                                Text(weatherManager.humidity)
                                    .font(.subheadline)
                            } icon: {
                                Image(systemName: "humidity")
                            }
                            .labelStyle(.titleAndIcon)
                            .foregroundStyle(.blue)
                        }.padding()
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                .shadow(radius: 1, x: 1, y: 1)
                
                // 💧 Sélection de l’humidité à enregistrer
                VStack(spacing: 16) {
                    Text("Taux d’humidité à enregistrer")
                        .font(.headline)
                    
                    Picker("Humidité", selection: $selectedHumidity) {
                        ForEach(0..<101) { value in
                            Text("\(value) %")
                                .tag(value)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                    
                    Text("Valeur sélectionnée : \(selectedHumidity)%")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal)
                
                Spacer()
                
                // ✅ Bouton d’enregistrement
                Button {
                    saveHumidityRecord()
                } label: {
                    Label("Enregistrer", systemImage: "checkmark.circle.fill")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                }
                .padding(.horizontal)
                
            }
            .padding()
            .navigationTitle("Nouvelle mesure humidité")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func saveHumidityRecord() {
            // Création du DTO
            guard let weatherHumidity = Double(weatherManager.humidity.replacingOccurrences(of: "%", with: "")) else {
                print("Erreur parsing météo humidité")
                return
            }
            
            let dto = HumidityMeasureDto(
                hotHouseId: hotHouse.id,
                humidityMeasuredInsideHotHouse: Double(selectedHumidity),
                humidityFromWeather: weatherHumidity,
                timestamp: Date()
            )
            
            // Appel ViewModel
            vm.addHumidityRecord(dto: dto)
            
            dismiss()
        }
}
