import Foundation
import Factory

extension AllDailyReportView {
    
    @MainActor
    @Observable
    class ViewModel {
        
        private let globalRepository: GlobalRepository
        
        init(globalRepository: GlobalRepository) {
            self.globalRepository = globalRepository
        }
        
        private(set) var currentHotHouse: HotHouseModel? = nil
        
        
        // Fake data pour le preview / test
        private(set) var dailyReportsToday: [DailyReportModel] = [
            DailyReportModel(
                id: "1",
                hotHouseId: "1",
                hotHouseName: "Serre sample 1",
                isSubmitted: false,
                temperatureMeasurements: [
                    TemperatureMeasureModel(hotHouseId: "1", temperatureMeasuredInsideHotHouse: 22, temperatureFromWeather: 21, timestamp: .now),
                    TemperatureMeasureModel(hotHouseId: "1", temperatureMeasuredInsideHotHouse: 24, temperatureFromWeather: 23, timestamp: .now)
                ],
                humidityMeasurements: [
                    HumidityMeasureModel(hotHouseId: "1", humidityMeasuredInsideHotHouse: 45, humidityFromWeather: 50, timestamp: .now)
                ],
                openedWindowsDurations: [
                    OpenedWindowsDurationModel(hotHouseId: "1", openWindowTime: "8h00", closeWindowTime: "10h00")
                ],
                rateOfTheDay: 0,
                date: .now,
                predictionOfTheDay: PredictionModel(
                    hotHouseId: "1",
                    openedWindowsDurationsPredicted: [
                        OpenedWindowsDurationModel(hotHouseId: "1", openWindowTime: "9h00", closeWindowTime: "11h00")
                    ]
                )
            ),
            DailyReportModel(
                id: "2",
                hotHouseId: "2",
                hotHouseName: "Serre sample 2",
                isSubmitted: true,
                temperatureMeasurements: [
                    TemperatureMeasureModel(hotHouseId: "2", temperatureMeasuredInsideHotHouse: 18, temperatureFromWeather: 17, timestamp: .now)
                ],
                humidityMeasurements: [
                    HumidityMeasureModel(hotHouseId: "2", humidityMeasuredInsideHotHouse: 60, humidityFromWeather: 65, timestamp: .now)
                ],
                openedWindowsDurations: [
                    OpenedWindowsDurationModel(hotHouseId: "2", openWindowTime: "14h00", closeWindowTime: "16h00")
                ],
                rateOfTheDay: 3,
                date: .now,
                predictionOfTheDay: PredictionModel(
                    hotHouseId: "2",
                    openedWindowsDurationsPredicted: [
                        OpenedWindowsDurationModel(hotHouseId: "2", openWindowTime: "15h00", closeWindowTime: "17h00")
                    ]
                )
            )
        ]
        
        // Simule un fetch asynchrone depuis le repository
        func getAllDailyReportsOfToday() {
            Task {
                do {
                    let reports = try await globalRepository.getAllDailyReportForToday()
                    self.dailyReportsToday = reports
                } catch {
                    print("Erreur lors de la récupération des DailyReports : \(error)")
                    self.dailyReportsToday = []
                }
            }
        }
        
        func getHotHouseById(id: String) {
            Task{
                do {
                    let result = try await globalRepository.getHotHouseById(id: id)
                    self.currentHotHouse = result
                } catch {
                    print("Erreur lors de la récupération de la hot house : \(error)")
                    self.currentHotHouse = nil
                }

            }
            
        }
        
        func submitRateToDailyReport(dto: SubmitRateDailyReportDto, reportId: String) {
            Task {
                do {
                    try await globalRepository.submitRateDailyReportById(dto: dto, reportId: reportId)
                } catch {
                    print("Erreur lors de l'update du rapport' : \(error)")
                }
            }
            
        }
        
    }
}
