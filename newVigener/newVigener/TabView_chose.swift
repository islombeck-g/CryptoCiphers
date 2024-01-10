import SwiftUI

struct TabView_chose: View {
    
    @StateObject var mainViewModel:ViewModel = ViewModel()
    var body: some View {
        TabView {
            
            MainView()
                .environmentObject(self.mainViewModel)
                .tabItem { Image(systemName: "1.circle") }
            CrackView()
                .environmentObject(self.mainViewModel)
                .tabItem { Image(systemName: "2.circle") }
        }
    }
}

#Preview {
    TabView_chose()
}
