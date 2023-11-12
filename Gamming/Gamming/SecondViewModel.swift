import Foundation

final class SecondViewModel:ObservableObject {
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
    
    @Published var error = ""
    @Published var uncError = ""
    
    let russianRegex = try! NSRegularExpression(pattern: "[А-Яа-яёЁ]")
    let englishRegex = try! NSRegularExpression(pattern: "[A-Za-z]")
    
    var ciepher = Ciepher()
    
    func cryptViewModel(){}
    
    
    func unCrypt(){
        
    }
    
    
    func balanceZerosAndOnes() {
        let lettersEN = "abcdefghijklmnopqrstuvwxyz"
        let lettersRu = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя"
        let chosenLetters = self.chosenLanguage == "EN" ? lettersEN : lettersRu

        let randomString = String((0..<self.textForCrypt.count).map { _ in
            let randomIndex = Int.random(in: 0..<chosenLetters.count)
            let character = chosenLetters[chosenLetters.index(chosenLetters.startIndex, offsetBy: randomIndex)]
            return character
        })

        self.keyForCrypt = String(randomString.shuffled())
        toBinar()
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
