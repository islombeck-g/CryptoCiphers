import SwiftUI

struct TabView_chose: View {
    var body: some View {
        TabView{
            MainView()
                .tabItem{ Image(systemName: "1.circle") }
            
            CrackView()
                .tabItem { Image(systemName: "2.circle") }
            
        }
    }
}

#Preview {
    TabView_chose()
}
