//
//  HomeViewModel.swift
//  PsyBudgetIOS
//
//  Created by lucas mercier on 13/04/2025.
//

import Foundation
import Factory


extension HomeView {
    
    @MainActor
    @Observable
    class ViewModel {
        
        private let globalRepository : GlobalRepository
        
        init(globalRepository: GlobalRepository) {
            self.globalRepository = globalRepository
        }
        
        private(set) var hotHousesWithPredictionsList: [HotHouseWithPredictionModel] = [
            HotHouseWithPredictionModel(
                hotHouse: HotHouseModel(
                    id: "1",
                    name: "Serre tomates",
                    address: Address(addressStreet: "", postalCode: "13000", city: "Marseille"),
                    location: LocalisationGps(latitude: 43.300000, longitude: 5.400000),
                    temperatureThresholdMax: 26.0,
                    temperatureThresholdMin: 18.0,
                    humidityThresholdMax: 50.0,
                    humidityThresholdMin: 20.0
                    
                ),
                predictionsOfTheDay: PredictionModel(hotHouseId: "1", openedWindowsDurationsPredicted: [
                    OpenedWindowsDurationModel(hotHouseId:"1",openWindowTime: "8h00", closeWindowTime: "10h00"),
                    OpenedWindowsDurationModel(hotHouseId:"1",openWindowTime: "14h00", closeWindowTime: "17h00")
                ])),
            HotHouseWithPredictionModel(
                hotHouse: HotHouseModel(
                    id: "2",
                    name: "Serre champignons",
                    address: Address(addressStreet: "", postalCode: "75000", city: "Paris"),
                    location: LocalisationGps(latitude: 48.866667, longitude: 2.333333),
                    temperatureThresholdMax: 26.0,
                    temperatureThresholdMin: 18.0,
                    humidityThresholdMax: 50.0,
                    humidityThresholdMin: 20.0
                ),
                predictionsOfTheDay: PredictionModel(hotHouseId: "2", openedWindowsDurationsPredicted: [
                    OpenedWindowsDurationModel(hotHouseId:"2",openWindowTime: "8h00", closeWindowTime: "10h00"),
                    OpenedWindowsDurationModel(hotHouseId:"2",openWindowTime: "14h00", closeWindowTime: "17h00")
                ]))
        ]
        
        
        
        func testAPI() {
            print("testAPI tapped")
            Task {
                do {
                    print("Starting request")
                    let url = URL(string: "https://api.chucknorris.io/jokes/random")!
                    let (data, response) = try await URLSession.shared.data(from: url)
                    print("Response:", response)
                    print("Data length:", data.count)

                    let decoder = JSONDecoder()
                    // L’API renvoie des clés snake_case, on peut soit mapper en camelCase, soit garder les mêmes noms.
                    // Si tu préfères des propriétés Swift camelCase, ajoute:
                    // decoder.keyDecodingStrategy = .convertFromSnakeCase

                    let joke = try decoder.decode(ChuckNorrisJoke.self, from: data)
                    print("Joke ID:", joke.id)
                    print("Icon URL:", joke.iconUrl)
                    print("URL:", joke.url)
                    print("Value:", joke.value)

                    // Si tu es en SwiftUI, tu peux stocker `joke.value` dans un @State ou @Observable pour l’afficher dans la vue.
                } catch {
                    print("Decoding or request error:", error)
                }
            }
        }
        
        func testApiGeneric(){
            Task{
                do{
                    try await globalRepository.getTest()
                } catch{
                    print("Decoding or request error:", error)
                }
            }
            
        }
        
        
        

        @MainActor
        func testReqBinDirect() async {
            let url = URL(string: "https://reqbin.com/echo/post/json")!
            let token = "{token}"
            let payload = EchoPayload(employee: Employee(name: "Emma", age: 28, city: "Boston"))
            
            do {
                let body = try JSONEncoder().encode(payload)
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.httpBody = body
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                
                let (data, response) = try await URLSession.shared.data(for: request)
                guard let http = response as? HTTPURLResponse else { print("Réponse invalide"); return }
                print("Status:", http.statusCode)
                print("Body:", String(data: data, encoding: .utf8) ?? "<binary>")
            } catch {
                print("Erreur:", error)
            }
        }

    }
         
}

struct Employee: Encodable {
    let name: String
    let age: Int
    let city: String
}
struct EchoPayload: Encodable {
    let employee: Employee
}

struct ChuckNorrisJoke: Decodable {
    let iconUrl: String
    let id: String
    let url: String
    let value: String
    
    private enum CodingKeys: String, CodingKey {
        case iconUrl = "icon_url" // explicite
        case id, url, value       // direct
    }
}
