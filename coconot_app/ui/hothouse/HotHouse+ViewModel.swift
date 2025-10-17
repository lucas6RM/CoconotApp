import Foundation
import Factory

extension HotHouseView {

    @MainActor
    @Observable
    class ViewModel {

        private let globalRepository: GlobalRepository

        init(globalRepository: GlobalRepository) {
            self.globalRepository = globalRepository
        }

        // MARK: - Observable list
        private(set) var hotHouses: [HotHouseModel] = []
        
        var currentHouse: HotHouseModel? = HotHouseModel.empty()
        
        

        // MARK: - CRUD async calls
        func getHotHouses() {
            Task{
                do {
                    let result = try await globalRepository.getAllHotHouses()
                    self.hotHouses = result
                    
                } catch {
                    print("Erreur getHotHouses:", error)
                    self.hotHouses = []
                    
                }
            }
        }

        func addHotHouse(_ dto: CreateHotHouseDto) {
            Task {
                do {
                    try await globalRepository.createHotHouse(dto: dto)
                    getHotHouses()
                } catch {
                    print("Erreur addHotHouse:", error)
                }
            }
        }

        func editHotHouse(dto: UpdateHotHouseDto) {
            Task{
                do {
                    try await globalRepository.updateHotHouse(dto: dto)
                    getHotHouses()
                } catch {
                    print("Erreur editHotHouse:", error)
                }
            }
            
        }

        @MainActor
        func getHotHouseById(hotHouseId: String) async {
            
            do {
                let hotHouseModel = try await globalRepository.getHotHouseById(id: hotHouseId)
                self.currentHouse = hotHouseModel
            } catch {
                print("Erreur getHotHouseById:", error)
                self.currentHouse = nil
            }
            
        }

        func deleteHotHouseById(hotHouseId: String) {
            Task{
                do {
                    try await globalRepository.deleteHotHouseById(id: hotHouseId)
                    getHotHouses()
                } catch {
                    print("Erreur deleteHotHouseById:", error)
                }
            }
            
        }
    }
}
