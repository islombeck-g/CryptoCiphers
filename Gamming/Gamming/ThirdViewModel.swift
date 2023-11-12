import Foundation

final class ThirdViewModel: ObservableObject {
    @Published var chosenLanguage = "EN"
    @Published var textForCrypt = ""
    @Published var binaryTextForCrypt = ""
    @Published var keyForCrypt = ""
    @Published var binaryKeyForCrypt = ""
    
    @Published var resultIsReady = false
    @Published var resultText = ""
    @Published var resultBinarText = ""
    
    
    @Published var uncryptIsReady = false
    @Published var uncryptResultText = ""
    @Published var uncryptResultBinarText = ""
        
    
    let russianRegex = try! NSRegularExpression(pattern: "[А-Яа-яёЁ]")
    let englishRegex = try! NSRegularExpression(pattern: "[A-Za-z]")
    
    var ciepher = Ciepher()
    
    
@Published var error = ""
@Published var uncError = ""
    func cryptViewModel(){}
    
    
    func unCrypt(){
        
       
    }
    
    func toBinar(){
        self.binaryTextForCrypt = ciepher.stringToBinary(textForCrypt)
        self.binaryKeyForCrypt = ciepher.stringToBinary(keyForCrypt)
    }
    private func isTextInLanguage(_ text: String, selectedLanguage: String) -> Bool {
        
        switch chosenLanguage {
        case "RU":
            return englishRegex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)) == nil
        case "EN":
            return russianRegex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)) == nil
        default:
            return false
        }
    }

}
