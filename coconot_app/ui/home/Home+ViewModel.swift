//
//  HomeViewModel.swift
//  PsyBudgetIOS
//
//  Created by lucas mercier on 13/04/2025.
//

import Foundation
import Factory

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

extension HomeView {
    
    @MainActor
    @Observable
    class ViewModel {
        
        private let globalRepository : GlobalRepository
        
        init(globalRepository: GlobalRepository) {
            self.globalRepository = globalRepository
        }
        
        
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
