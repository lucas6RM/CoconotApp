
import SwiftUI
import Factory

struct HotHouseView: View {
    
    
    @State private var vm = Container.shared.hotHouseViewModel()
    
    var body: some View {
        VStack {
            Text("HotHouseView")
        }
        
    }
   
}
