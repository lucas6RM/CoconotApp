import SwiftUI
import Factory

struct HotHouseView: View {
    
    @State private var vm = Container.shared.hotHouseViewModel()
    @State private var isPresentedAddHotHouse = false
    @State private var selectedHotHouseId: String? = nil
    
    // trick pour recomposer la vue après une modif patient
    @State private var refreshId = UUID()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.hotHouses, id: \.id) { hotHouse in
                    HStack {
                        
                        
                        NavigationLink(destination: AddEditHotHouseView(selectedHotHouseId: hotHouse.id) {
                            vm.getHotHouses()
                        }) {
                            VStack(alignment: .leading) {
                                Text(hotHouse.name)
                                if let addr = hotHouse.address {
                                    Text("\(addr.addressStreet), \(addr.postalCode) \(addr.city)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }.onDisappear {
                            vm.getHotHouses()
                            refreshId = UUID()
                        }
                    }
                }.id(refreshId)
            }
            .navigationTitle("Mes Serres")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        self.selectedHotHouseId = nil
                        isPresentedAddHotHouse = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentedAddHotHouse) {
                AddEditHotHouseView(selectedHotHouseId: selectedHotHouseId) {
                    vm.getHotHouses()
                    isPresentedAddHotHouse = false
                    
                }.onDisappear {
                    vm.getHotHouses()
                    refreshId = UUID()
                }
            }
        }
        .task {
            vm.getHotHouses()
        }
    }
}

#Preview {
    HotHouseView()
}
