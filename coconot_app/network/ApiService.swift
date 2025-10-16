//
//  ApiService.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//

import Foundation

import Foundation

enum APIError: Error {
    case invalidURL
    case transport(Error)
    case badStatus(Int)
    case decoding(Error)
}

class ApiService {
    private let session: URLSession
    private let baseURL: URL? = URL(string: "https://reqbin.com")

    init(session: URLSession = .shared) {
        self.session = session
    }

    // Generic GET
    func get<T: Decodable>(_ path: String, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        let url = try makeURL(path: path)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return try await run(request, decoder: decoder)
    }

    // Generic POST (optional, handy to have; remove if you don't need it)
    func post<T: Decodable, B: Encodable>(
        _ path: String,
        body: B,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        let url = try makeURL(path: path)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try encoder.encode(body)
        return try await run(request, decoder: decoder)
    }

    // Core runner shared by all HTTP methods
    private func run<T: Decodable>(_ request: URLRequest, decoder: JSONDecoder) async throws -> T {
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await session.data(for: request)
        } catch {
            throw APIError.transport(error)
        }

        guard let http = response as? HTTPURLResponse else {
            throw APIError.badStatus(-1)
        }
        guard (200..<300).contains(http.statusCode) else {
            throw APIError.badStatus(http.statusCode)
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decoding(error)
        }
    }

    private func makeURL(path: String) throws -> URL {
        if let baseURL {
            guard let url = URL(string: path, relativeTo: baseURL) else { throw APIError.invalidURL }
            return url
        } else {
            guard let url = URL(string: path) else { throw APIError.invalidURL }
            return url
        }
    }
}


extension ApiService {
    
    func getAllHotHousesWithPrediction() async throws -> [HotHouseWithPredictionDto] {
        try await get("/hothouses/predictions")
    }
    
    func getGitHubTestApi() async throws -> String {
        let test : String = try await get("/jokes/random")
        print(test)
        debugPrint("erreur")
        return test
    }
    
    func getRandomChuckJoke() async throws -> ChuckNorrisJoke {
        // Pas besoin de keyDecodingStrategy car on a CodingKeys
        try await get("/jokes/random")
    }
    
    
}



/* old version
 class ApiService {

     // If your endpoint returns an array of HotHouseWithPredictionsDto
     func getAllHotHousesWithPredictions() async throws -> [HotHouseWithPredictionDto] {
         // Replace with your real endpoint URL
         let url = URL(string: "https://api.example.com/hot-houses/predictions")!
         let (data, _) = try await URLSession.shared.data(from: url)
         return try JSONDecoder.backendDefault().decode([HotHouseWithPredictionDto].self, from: data)
     }

     // If your endpoint returns a wrapper object:
     // func getAllHotHousesWithPredictions() async throws -> [HotHouseWithPredictionDto] {
     //     let url = URL(string: "https://api.example.com/hot-houses/predictions")!
     //     let (data, _) = try await URLSession.shared.data(from: url)
     //     let wrapper = try JSONDecoder.backendDefault().decode(HotHousesWithPredictionsResponseDto.self, from: data)
     //     return wrapper.items
     // }
 }

 */






/// sample
/*
 struct HotHousePrediction: Decodable {
     let probability: Double
     let label: String
 }

 struct HotHouse: Decodable {
     let id: String
     let name: String
     let location: String
     let prediction: HotHousePrediction?
 }

 extension ApiService {
     func getAllHotHousesWithPrediction() async throws -> [HotHouse] {
         try await get("/hothouses/predictions")
     }
 }

 // Calling it
 let api = ApiService(baseURL: "https://api.yourdomain.com")

 Task {
     do {
         let hotHouses = try await api.getAllHotHousesWithPrediction()
         print("Loaded:", hotHouses.count)
     } catch let error as APIError {
         print("API error:", error)
     } catch {
         print("Unexpected error:", error)
     }
 }
 */
