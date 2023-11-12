import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            First()
                .tabItem{ Image(systemName: "1.circle") }
            
            Second()
                .tabItem { Image(systemName: "2.circle") }
            
            Third()
                .tabItem{ Image(systemName: "3.circle") }
        }
    }
}

#Preview {
    ContentView()
}
