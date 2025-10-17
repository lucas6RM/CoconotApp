//
//  HomeView.swift
//  PsyBudgetIOS
//
//  Created by lucas mercier on 23/03/2025.
//

import SwiftUI
import Charts
import Factory



struct HomeView: View {
    
    
    @State private var vm = Container.shared.homeViewModel()
    
    @AppStorage("defaultUserName") var userNameValue = ""
    
    @State private var isSettingsShowed = false
    
    @State private var presentedSheet: PresentedSheet?
    
    @State private var selectedHotHouse: HotHouseModel? = nil
    
    
    var body: some View {
        
            
        NavigationStack {
            ScrollView {
                
            VStack {
                ForEach(vm.hotHousesWithPredictionsList, id: \.hotHouse.id){ hotHouseWithPrediction in
                    CardHomeComponent(
                        hotHouse: hotHouseWithPrediction.hotHouse,
                        predictions:hotHouseWithPrediction.predictionsOfTheDay?.openedWindowsDurationsPredicted ?? [],
                        // Dans tes callbacks:
                        onClickTemperature: { hotHouse, weatherData in
                            presentedSheet = .temperature(hotHouse, weatherData)
                        },
                        onClickHumidity: { hotHouse, weatherData in
                            presentedSheet = .humidity(hotHouse, weatherData)
                        },
                        onClickOpenedWindow: { hotHouse, weatherData in
                            presentedSheet = .openings(hotHouse, weatherData)
                        })
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Bonjour \(userNameValue)!")
                        .font(.headline)
                }
                ToolbarItem (placement: .topBarTrailing){
                    Button("Settings", systemImage: "gearshape", action: {
                        isSettingsShowed = true
                    })
                }
            }
            .sheet(
                isPresented: $isSettingsShowed,
                onDismiss: {
                    isSettingsShowed = false
                },
                content: {
                    SettingsView()
                })
            // Une seule sheet:
            .sheet(item: $presentedSheet, onDismiss: {
                presentedSheet = nil
            }) { sheet in
                switch sheet {
                case .temperature(let h, let w):
                    AddTemperatureRecordView(hotHouse: h, weatherManager: w)
                case .humidity(let h, let w):
                    AddHumidityRecordView(hotHouse: h, weatherManager: w)
                case .openings(let h, let w):
                    AddOpeningsRecordView(hotHouse: h, weatherManager: w)
                }
            }
        }.task {
            vm.fetchAllHotHouses()
        }
    }
    
    }
    
    enum PresentedSheet: Identifiable {
        case temperature(HotHouseModel, WeatherManager)
        case humidity(HotHouseModel, WeatherManager)
        case openings(HotHouseModel, WeatherManager)

        var id: String {
            switch self {
            case .temperature(let h, _): return "temp-\(h.id)"
            case .humidity(let h, _): return "hum-\(h.id)"
            case .openings(let h, _): return "open-\(h.id)"
            }
        }

        var hotHouse: HotHouseModel {
            switch self {
            case .temperature(let h, _), .humidity(let h, _), .openings(let h, _):
                return h
            }
        }
        
        var weatherData: WeatherManager {
            switch self {
            case .temperature(_, let w), .humidity(_, let w),.openings(_, let w): return w
            }
        }
    }
    
}


#Preview {
    HomeView()
}
