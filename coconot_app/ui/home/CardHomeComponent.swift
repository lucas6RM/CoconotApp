//
//  CardHomeComponent.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//

import SwiftUI

struct CardHomeComponent: View {
    let hotHouseId: String
    let hotHouseName: String
    let temperatureWeather: String
    let iconWeather: String
    let times: [(String, String)]
    
    let onClickTemperature: (String) -> ()
    let onClickHumidity: (String) -> ()
    let onClickOpenedWindow: (String) -> ()
    
    

    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            // Header avec le nom et température
                VStack{
                    HStack {
                        Text(hotHouseName)
                            .font(.title)
                        Spacer()
                        Text(temperatureWeather)
                            .font(.headline)
                        Image(systemName: iconWeather)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .foregroundColor(.yellow)
                        
                    }.padding(.bottom)
                    
                    HStack {
                        VStack(alignment: .trailing ,spacing: 20){
                            ForEach(times, id: \.0) { start, end in
                                HStack {
                                    VStack(spacing: 4) {
                                        Image(systemName: "window.casement")
                                    }
                                    Text("\(start) - \(end)")
                                        .font(.subheadline)
                                    Spacer()
                                }
                            }
                        }
                        
                         Menu {
                             Button {
                                 onClickTemperature(hotHouseId)
                             } label: {
                                 Label("Température", systemImage: "thermometer")
                             }

                             Button {
                                 onClickHumidity(hotHouseId)
                             } label: {
                                 Label("Humidité", systemImage: "drop")
                             }

                             Button {
                                 onClickOpenedWindow(hotHouseId)
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
                
            }
            
        
        .padding()
        .background(Color(.systemGray6))
    
        .cornerRadius(16)
        .shadow(radius: 1, x: 1, y: 1)
    }
}

struct CardHomeComponent_Previews: PreviewProvider {
    static var previews: some View {
        CardHomeComponent(
            hotHouseId: "2",
            hotHouseName: "Serre 1",
            temperatureWeather: "20°C",
            iconWeather: "sun.max.fill",
            times: [("08h00", "12h00"), ("14h00", "16h30"),("20h00", "8h00")],
            onClickTemperature: {_ in },
            onClickHumidity: {_ in },
            onClickOpenedWindow: {_ in }
        )
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
