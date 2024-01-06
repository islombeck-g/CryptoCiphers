import Foundation

class MainViewModel:ObservableObject {
    
    @Published var chosenLanguage: Languages = .english
    @Published var textForCrypt: String = ""
    @Published var keyForCrypt: String = ""
    

    @Published var errorInCrypt:String? = "some error1adsfkjasndfkjadsnflkandsf"
    @Published var errorInUncrypt:String? = "some error2"
    
    @Published var cryptResult:String? = "CryptResult One of the most common uses of animations in app development is to animate transitions between views. SwiftUI makes this task incredibly easy with its built-in support for view transitions."
    @Published var unCryptResult:String? = "unCryptResult One of the most common uses of animations in app development is to animate transitions between views. SwiftUI makes this task incredibly easy with its built-in support for view transitions."
    
    
    func ClearAll() {
        self.chosenLanguage = .english
        self.textForCrypt = ""
        self.keyForCrypt = ""
        self.errorInCrypt = nil
        self.errorInUncrypt = nil
        self.cryptResult = nil
        self.unCryptResult = nil
    }
}
