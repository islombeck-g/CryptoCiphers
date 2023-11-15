import Foundation

final class SecondViewModel:ObservableObject {
    @Published var chosenLanguage = "EN"
    @Published var textForCrypt = ""
    @Published var binaryTextForCrypt = ""
//    @Published var keyForCrypt = ""
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
    
    func clear() {
        chosenLanguage = "EN"
        textForCrypt = ""
        binaryTextForCrypt = ""
//        keyForCrypt = ""
        binaryKeyForCrypt = ""
        resultIsReady = false
        resultText = ""
        resultBinarText = ""
        uncryptIsReady = false
        uncryptResultText = ""
        uncryptResultBinarText = ""
        error = ""
        uncError = ""
    }
    
    func newKey() {
        var me = self.ciepher.stringToBinary(textForCrypt)
        var me2 = me.components(separatedBy: " ")
        self.binaryKeyForCrypt =  self.ciepher.randKey(me2.count)
    }
    
    func tryCrypt() {
        self.resultIsReady = false
        if checkDataForCrypt() {
            self.error = ""
            (self.resultText, self.resultBinarText) = ciepher.firstMCrypt(textForCrypt,binaryKeyForCrypt)
            self.resultIsReady = true
        }
    }
    
    func unCrypt(){
        self.uncryptIsReady = false
        (self.uncryptResultText, self.uncryptResultBinarText) = ciepher.firstMUnCrypt(self.resultBinarText, binaryKeyForCrypt)
        self.uncryptIsReady = true
    }
    
    func toBinar(){
        self.binaryTextForCrypt = ciepher.stringToBinary(textForCrypt)
//        self.binaryKeyForCrypt = ciepher.stringToBinary(keyForCrypt)
    }
    
    private func checkDataForCrypt() -> Bool{
        guard self.textForCrypt != "" else {
            self.error = "Введите текст для шифрования"
            return false
        }
        guard self.binaryKeyForCrypt != "" else {
            self.error = "Забыли создать рандомный ключ"
            return false
        }
        guard self.isTextInLanguage(self.textForCrypt, selectedLanguage: self.chosenLanguage) else {
            self.error = "Язык выбран другой, в слове обнаружены буквы из другого алфавита"
            return false
        }
        return true
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
