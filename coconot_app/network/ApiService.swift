//
//  ApiService.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case transport(Error)
    case badStatus(Int)
    case decoding(Error)
}

class ApiService {
    private let session: URLSession
    private let baseURL: URL? = URL(string: "https://coconot-backend-production.up.railway.app/api/v1")

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
    
    func patch<T: Decodable, B: Encodable>(
            _ path: String,
            body: B,
            encoder: JSONEncoder = JSONEncoder(),
            decoder: JSONDecoder = JSONDecoder()
        ) async throws -> T {
            let url = try makeURL(path: path)
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try encoder.encode(body)
            return try await run(request, decoder: decoder)
        }
        
        /// Version PATCH sans retour de données
        func patch<B: Encodable>(
            _ path: String,
            body: B,
            encoder: JSONEncoder = JSONEncoder()
        ) async throws {
            let _: EmptyResponse = try await patch(path, body: body, encoder: encoder, decoder: JSONDecoder())
        }
    
    /// DELETE générique avec retour décodable
    func delete<T: Decodable>(_ path: String, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        let url = try makeURL(path: path)
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        return try await run(request, decoder: decoder)
    }
    
    /// DELETE générique sans retour (EmptyResponse)
    func delete(_ path: String) async throws {
        let _: EmptyResponse = try await delete(path, decoder: JSONDecoder())
    }

    private func makeURL(path: String) throws -> URL {
        guard let baseURL else { throw APIError.invalidURL }
            guard let url = URL(string: baseURL.absoluteString + path) else { throw APIError.invalidURL }
            return url
    }
    
    /// Helper struct vide pour patch sans retour
    struct EmptyResponse: Decodable {}
}


extension ApiService {
    
    
    func getAllHotHousesWithPredictions() async throws -> [HotHouseWithPredictionDto] {
        return try await get("/hothouses/with-predictions")
    }
    
    func getAllHotHousesDailyReport(date: Date = .now) async throws -> [DailyReportDto] {
        return try await get("/daily-reports")
    }
    
    func addHumidity(dto: HumidityMeasureDto) async throws {
        let _ : HumidityMeasureResponseDto = try await post("/humidity-measures", body: dto)
    }
    
    func addTemperature(dto: TemperatureMeasureDto) async throws {
        let _ : TemperatureMeasureResponseDto = try await post("/temperature-measures", body: dto)
    }
    
    func addOpenings(dto: OpenedWindowsDurationDto) async throws {
        let _ : OpenedWindowsDurationDto = try await post("/opening-measures", body: dto)
    }
    
    func getHotHouseById(id: String) async throws -> HotHouseDto {
        return try await get("/hothouses/\(id)")
    }
    
    func getAllHotHouses() async throws -> [HotHouseDto] {
        return try await get("/hothouses")
    }
    
    
    
    
}
