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
    @State private var isAddTemperatureShowed = false
    @State private var isAddHumidityShowed = false
    @State private var isAddOpeningsShowed = false
    @State private var selectedHotHouseId: String? = nil
    
    
    var body: some View {
        NavigationStack {
            VStack {
                CardHomeComponent(
                    hotHouseId: "1",
                    hotHouseName: "Serre 1",
                    temperatureWeather: "20°C",
                    iconWeather: "sun.max.fill",
                    times: [("08h00", "12h00"), ("14h00", "16h30"),("20h00", "8h00")],
                    onClickTemperature: { hotHouseId in
                        self.selectedHotHouseId = hotHouseId
                        isAddTemperatureShowed = true
                    },
                    onClickHumidity: { hotHouseId in
                        self.selectedHotHouseId = hotHouseId
                        isAddHumidityShowed = true
                    },
                    onClickOpenedWindow: { hotHouseId in
                        self.selectedHotHouseId = hotHouseId
                        isAddOpeningsShowed = true
                    }
                )
                
                
                Button("Test api") {
                    //vm.testAPI()
                    //vm.testApiGeneric()
                    Task {
                        await vm.testReqBinDirect()
                    }
                }
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
            .sheet(
                isPresented: $isAddTemperatureShowed,
                onDismiss: {
                    isAddTemperatureShowed = false
                    self.selectedHotHouseId = nil
            },
            content: {
                AddTemperatureRecordView()
            })
            .sheet(
                isPresented: $isAddHumidityShowed,
                onDismiss: {
                    isAddHumidityShowed = false
                    self.selectedHotHouseId = nil
            },
            content: {
                if let id = self.selectedHotHouseId {
                    AddHumidityRecordView(hotHouseId: id)
                }
            })
            .sheet(
                isPresented: $isAddOpeningsShowed,
                onDismiss: {
                    isAddOpeningsShowed = false
                    self.selectedHotHouseId = nil
            },
            content: {
                AddOpeningsRecordView()
            })
            
        }
    }
   
}


#Preview {
    HomeView()
}
