import Foundation

class ViewModel:Ciepher, ObservableObject {
    
    @Published var chosenLanguage: Languages = .english
    @Published var textForCrypt: String = ""
    @Published var keyForCrypt: String = ""
    
    @Published var errorInCrypt:String?
    @Published var errorInUncrypt:String?
    
    @Published var cryptResult:String?
    @Published var unCryptResult:String?
    
    @Published var isLoading = false
    
    func clearText(_ text:String) -> String {
        var res = ""
        
        for i in text {
            let character = i.lowercased()
            
            if englishLanguage.contains(character) || russianLanguage.contains(character) || numbers.contains(character) {
                res.append(character)
            }
        }
        return res
    }
    
    func startCrypt() {
        self.isLoading = true
        self.errorInCrypt = nil
        self.errorInUncrypt = nil
        self.cryptResult = nil
        self.unCryptResult = nil
        
        guard check(textForCrypt, keyForCrypt) else { self.isLoading = false; return }
        
        self.cryptResult = encryptText(textForCrypt, keyForCrypt, chosenLanguage: self.chosenLanguage)
        
        self.isLoading = false
    }
    
    func startUncrypt() {
        self.isLoading = true
        self.errorInCrypt = nil
        self.errorInUncrypt = nil
        
        self.unCryptResult = decrypt(cryptResult!, keyForCrypt, chosenLanguage: self.chosenLanguage)
        
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
    
    func checkData(_ textForCrypt: String, _ keyForCrypt:String) ->(Bool, Bool) {
        
        var returnT = true
        var returnK = true
        let curAlphabet:[Character]?
        
        if chosenLanguage == .english {
            curAlphabet = englishLanguage
        } else {
            curAlphabet = russianLanguage
        }
        let text = textForCrypt.lowercased()
        for i in text {
            if i == " " { continue }
            if numbers.contains(i) { continue }
            if curAlphabet!.contains(i) { continue }
            returnT = false
            break
        }
        
        for i in keyForCrypt {
            if numbers.contains(i) { continue }
            if curAlphabet!.contains(i) { continue }
            returnK = false
            break
        }
        
        return (returnT, returnK)
    }
    func check(_ textForCrypt: String, _ keyForCrypt:String) -> Bool {
        
        guard textForCrypt != "" else {self.errorInCrypt = "Текст для шифрования отсутствует"; return false}
        guard keyForCrypt != "" else {self.errorInCrypt = "Ключ для шифрования отсутствует"; return false}
        
        let (errorText, errorKey) = self.checkData(textForCrypt, keyForCrypt)
        guard errorText else { self.errorInCrypt = "В тексте для шифрования ошибка"; return false }
        guard errorKey else { self.errorInCrypt = "В ключе для шифрования ошибка"; return false }
        
        return true
    }
    
//    CrackPart
    @Published var textforUncrypt:String = ""
    @Published var resultOFCrack:String = ""
    @Published var resultKey:String = ""
    @Published var startHack:Bool = false
    @Published var hackError:String?
    @Published var chosenLanguageForHack:Languages = .english
    
    func clearCryptView() {
        textforUncrypt = ""
        resultOFCrack = ""
        resultKey = ""
    }
    
    func tryHack() {
        startHack = true
        hackError = nil
        
        if checkForHack() {
            print("me")
            (resultOFCrack, resultKey) = hack1(cryptResult!, me: unCryptResult!, chosenLanguage: self.chosenLanguageForHack)
        }
        
        startHack = false
    }
    
    func checkForHack() ->Bool {
        
        let alphabet = self.chosenLanguageForHack == .english ? englishLanguage + numbers: russianLanguage + numbers
        
        for i in textforUncrypt {
            if !alphabet.contains(i) {
                hackError = "Присутствуют неопознанные символы"
                return false
            }
        }
        
        var whichLanguage:Languages = .english
        
        if unCryptResult == nil {
            hackError = "что то не так("
            return false
        } else {
            for i in unCryptResult! {
                if numbers.contains(i) {continue}
                if englishLanguage.contains(i) {whichLanguage = .english}
                if russianLanguage.contains(i) {whichLanguage = .russian}
            }
            if whichLanguage != chosenLanguageForHack {
                hackError = "что то не так1("
                return false
            }
        }
        return true
    }
}
