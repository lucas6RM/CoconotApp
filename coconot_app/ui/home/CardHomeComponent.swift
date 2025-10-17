//
//  CardHomeComponent.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//

import SwiftUI

struct CardHomeComponent: View {
    
    @State private var weatherManager = WeatherManager()
    
    let hotHouse: HotHouseModel
    
    let predictions: [OpenedWindowsDurationModel]
    
    let onClickTemperature: (HotHouseModel, WeatherManager) -> ()
    let onClickHumidity: (HotHouseModel, WeatherManager) -> ()
    let onClickOpenedWindow: (HotHouseModel, WeatherManager) -> ()
    

    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            // Header avec le nom et température
                VStack{
                    HStack(alignment: .top, spacing: 12) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(hotHouse.name)
                                .font(.title2).fontWeight(.semibold)
                                .foregroundStyle(.primary)
                            
                            // Ville en sous-titre
                            if let city = hotHouse.address?.city {
                                HStack(spacing: 6) {
                                    Text(city)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                }
                            }
                        }

                        Spacer()
                        VStack(alignment: .trailing,spacing: 20, content: {
                            Image(systemName:weatherManager.icon)
                                .symbolRenderingMode(.multicolor)
                                    
                                .font(.system(size: 34, weight: .semibold))
                                .frame(width: 44, height: 44)
                            
                            HStack(spacing: 20) {
                
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
                            
                        }).padding(.bottom,20)
                            
                            
                            
                        
            
                    }
                    
                    
                    HStack {
                        VStack(alignment: .trailing ,spacing: 20){
                            
                            ForEach(predictions) { prediction in
                                HStack {
                                    VStack(spacing: 4) {
                                        Image(systemName: "window.casement")
                                    }
                                    Text("\(prediction.openWindowTime) - \(prediction.closeWindowTime)")
                                        .font(.subheadline)
                                    Spacer()
                                }
                            }
                        }
                        
                        makeMenu()
                    }
                }.onAppear {
                    Task {
                        await weatherManager.getWeather(location: hotHouse.location)
                    }
                }
                
            }
            
        
        .padding()
        .background(Color(.systemGray6))
    
        .cornerRadius(16)
        .shadow(radius: 1, x: 1, y: 1)
    }
    
    private func makeMenu() -> some View {
        Menu {
            Button {
                onClickTemperature(hotHouse, weatherManager)
            } label: {
                Label("Température", systemImage: "thermometer")
            }

            Button {
                onClickHumidity(hotHouse, weatherManager)
            } label: {
                Label("Humidité", systemImage: "drop")
            }

            Button {
                onClickOpenedWindow(hotHouse, weatherManager)
            } label: {
                Label("Ouvertures", systemImage: "clock")
            }
        } label: {
            Text("Enregistrer données").padding(20)
                
        }
        .buttonStyle(.bordered)
        .tint(.mint)
    }
}

struct CardHomeComponent_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            
            
            CardHomeComponent(
                hotHouse: HotHouseModel(
                    id: "1",
                    name: "Serre tomates",
                    address: Address(addressStreet: "", postalCode: "13000", city: "Marseille"),
                    location: LocalisationGps(latitude: 43.300000, longitude: 5.400000),
                    temperatureThresholdMax: 26.0,
                    temperatureThresholdMin: 18.0,
                    humidityThresholdMax: 50.0,
                    humidityThresholdMin: 20.0,
                    
                ),
                predictions: [
                    OpenedWindowsDurationModel(hotHouseId:"1",openWindowTime: "8h00", closeWindowTime: "10h00"),
                    OpenedWindowsDurationModel(hotHouseId:"1",openWindowTime: "14h00", closeWindowTime: "17h00")
                ],onClickTemperature: {_,_ in }, onClickHumidity: {_,_ in }, onClickOpenedWindow: {_,_ in })
            Spacer()
        }
    }
}

