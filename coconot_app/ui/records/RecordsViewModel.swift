//
//  RecordsViewModel.swift
//  coconot_app
//
//  Created by lucas mercier on 17/10/2025.
//

import Foundation

@Observable
class RecordsViewModel{
    private let globalRepository : GlobalRepository
    
    init(globalRepository: GlobalRepository) {
        self.globalRepository = globalRepository
    }
    
    
    func addHumidityRecord(dto: HumidityMeasureDto) {
            Task {
                do {
                    // Ici tu pourrais appeler l'API via globalRepository
                    print("Envoi DTO humidité : \(dto)")
                    try await globalRepository.addHumidity(dto: dto)
                } catch {
                    print("Erreur lors de l'enregistrement de l'humidité : \(error)")
                }
            }
        }
    
    func addTemperatureRecord(dto: TemperatureMeasureDto) {
        Task {
            do {
                print("Envoi DTO température : \(dto)")
                // Ici, appel API ou stockage local via globalRepository
            } catch {
                print("Erreur lors de l'enregistrement de la température : \(error)")
            }
        }
    }
    
    
    func addOpeningsRecord(dto: OpenedWindowsDurationDto) {
            Task {
                do {
                    print("Envoi DTO ouverture fenêtres : \(dto)")
                    // Ici, appel API ou stockage local via globalRepository
                } catch {
                    print("Erreur lors de l'enregistrement des ouvertures : \(error)")
                }
            }
        }
}
