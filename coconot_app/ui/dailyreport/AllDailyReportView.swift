import SwiftUI
import Factory

struct AllDailyReportView: View {
    
    @State private var vm = Container.shared.dailyReportViewModel()
    
    var body: some View {
        NavigationStack {
            List(vm.dailyReportsToday, id: \.id) { report in
                NavigationLink(destination: DailyReportView(report: report)) {
                    HStack(alignment: .center, spacing: 6) {
                        
                        VStack(alignment: .leading, spacing: 10){
                            
                            Text("\(report.hotHouseName)")
                                .font(.headline)
                            
                            if !report.openedWindowsDurations.isEmpty {
                                Text("\(report.openedWindowsDurations.count) ouverture(s) aujourd'hui")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            } else {
                                Text("Aucune ouverture")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            if report.isSubmitted {
                                if let userRating = report.rateOfTheDay {
                                    HStack(spacing: 18) {
                                        ForEach(1...5, id: \.self) { star in
                                            Image(systemName: star <= userRating ? "star.fill" : "star")
                                                .foregroundColor(.yellow)
                                                .frame(width: 5)
                                        }
                                    }
                                }
                                
                            } else {
                                Text("Evaluer")
                                    .foregroundStyle(.blue)
                            }
                        }.padding()
                        
                        
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Rapports du jour")
            .task {
                // await vm.fetchDailyReports()
            }
        }
    }
}

