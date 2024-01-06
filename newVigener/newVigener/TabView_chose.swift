import SwiftUI

struct TabView_chose: View {
    
    @StateObject var mainViewModel:MainViewModel = MainViewModel()
    @StateObject var crackViewModel:CrackViewModel = CrackViewModel()
    var body: some View {
        TabView {
            
            MainView()
                .environmentObject(self.mainViewModel)
                .tabItem { Image(systemName: "1.circle") }
            CrackView()
                .environmentObject(self.crackViewModel)
                .tabItem { Image(systemName: "2.circle") }
        }
    }
}

#Preview {
    TabView_chose()
}
