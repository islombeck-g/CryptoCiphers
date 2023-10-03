import SwiftUI

struct MainView: View {
    
    @State private var text: String = ""
    
    var body: some View {
    
        TabView{
            FirstView()
                .tabItem{ Image(systemName: "1.circle") }
            
            SecondView()
                .tabItem { Image(systemName: "2.circle") }
            
            ThirdView()
                .tabItem{ Image(systemName: "3.circle") }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
