import Foundation

class MainViewModel:Ciepher, ObservableObject {
    
    @Published var chosenLanguage: Languages = .english
    @Published var textForCrypt: String = ""
    @Published var keyForCrypt: String = ""
    
    @Published var errorInCrypt:String?
    @Published var errorInUncrypt:String?
    
    @Published var cryptResult:String?
    @Published var unCryptResult:String?
    
    @Published var isLoading = false
    
    func startCrypt(){
        self.isLoading = true
        self.errorInCrypt = nil
        self.errorInUncrypt = nil
        self.cryptResult = nil
        self.unCryptResult = nil
        guard check() else { self.isLoading = false; return }
        
        if chosenLanguage == .english {
            self.cryptResult = self.cryptEN(constantText: textForCrypt, constantKey: keyForCrypt)
        } else {
            self.cryptResult = self.cryptRu(constantText: textForCrypt, constantKey: keyForCrypt)
        }
        
        self.isLoading = false
    }
    
    func startUncrypt() {
        self.isLoading = true
        self.errorInCrypt = nil
        self.errorInUncrypt = nil
        
        if chosenLanguage == .english {
            self.unCryptResult = unCryptEN(constantText: cryptResult!, constantKey: keyForCrypt)
        } else {
            self.unCryptResult = unCryptRU(constantText: cryptResult!, constantKey: keyForCrypt)
        }
        self.isLoading = false
    }
    
    
    //    isReady
    func ClearAll() {
        self.chosenLanguage = .english
        self.textForCrypt = ""
        self.keyForCrypt = ""
        self.errorInCrypt = nil
        self.errorInUncrypt = nil
        self.cryptResult = nil
        self.unCryptResult = nil
    }
    
    private func check() -> Bool {
        
        guard textForCrypt != "" else {self.errorInCrypt = "Текст для шифрования отсутствует"; return false}
        guard keyForCrypt != "" else {self.errorInCrypt = "Ключ для шифрования отсутствует"; return false}
        
        let (errorText, errorKey) = self.checkData()
        guard errorText else { self.errorInCrypt = "В тексте для шифрования ошибка"; return false }
        guard errorKey else { self.errorInCrypt = "В ключе для шифрования ошибка"; return false }
        
        return true
    }
    
    //    MARK: returns if all is good
    private func checkData() ->(Bool, Bool) {
        var returnT = true
        var returnK = true
        let curAlphabet:[Character]?
        let secAlphabet:[Character]?
        if chosenLanguage == .english {
            curAlphabet = russianLanguage
            secAlphabet = englishLanguage
        } else {
            curAlphabet = englishLanguage
            secAlphabet = russianLanguage
        }
        for i in textForCrypt {
            if String(i) == " " {continue}
            if numbers.contains(i) {continue}
            if curAlphabet!.contains(i) {
                returnT = false
                break
            }
        }
        
        for i in keyForCrypt {
            if String(i) == " " { continue }
            if numbers.contains(i) { continue }
            if secAlphabet!.contains(i) { continue }
            if curAlphabet!.contains(i) {
                returnK = false
                break
            }
            returnK = false
        }
        return (returnT, returnK)
    }
    
}
