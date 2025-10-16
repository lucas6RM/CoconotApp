//
//  GlobalRepository.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//

import Foundation
import Factory


@MainActor
@Observable
class GlobalRepository {
    
    private let apiService : ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getTest() async throws {
        let joke: ChuckNorrisJoke = try await apiService.getRandomChuckJoke()
        print(joke.value)
    }
    
    
}
    
