import SwiftUI
import Factory

struct AllDailyReportView: View {
    
    @State private var vm = Container.shared.dailyReportViewModel()
    @State private var presentedSheet: DailyReportModel? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                ForEach(vm.dailyReportsToday, id: \.hotHouseId) { report in
                    CardDailyReportComponent(
                        report: report,
                        onTap: { presentedSheet = report }
                    )
                    .padding(.horizontal)
                }
                Spacer()
            }
            .sheet(item: $presentedSheet) { report in
                DailyReportView(report: report)
            }
            .task {
                //await vm.fetchDailyReports()
            }
            .navigationTitle("Rapports du jour")
        }
    }
}

