import Foundation

final class MainViewModel:Ciepher, ObservableObject {
    
    @Published var language = "EN"
    @Published var textForCrypt = ""
    @Published var languages:[String] = ["EN", "RU"]
    
    @Published var keyForCrypt = ""
    @Published var errorMessage = ""
    @Published var encryptText_result = ""
    
    @Published var uncryptResult = ""
    @Published var uncryptErrorMessage = ""
 
    func crypt() {
        self.checkPassword()
        
        guard !self.textForCrypt.isEmpty else {
            self.errorMessage = "Ведите текст для шифрования"
            return
        }
        guard !self.keyForCrypt.isEmpty else {
            self.errorMessage = "Ведите ключ для шифрования"
            return
        }
        guard self.checkLanguage() else {
            self.errorMessage = "В введёном тексте присутствуют буквы из другого алфавита"
            return
        }
        
        if self.language == "EN" {
            self.encryptText_result = self.cryptEN(text: textForCrypt, constant_key: keyForCrypt)
        } else {
            self.encryptText_result = self.cryptRU(text: textForCrypt, constant_key: keyForCrypt)
        }
    }
    
    func uncrypt() {
        self.checkPassword()
        
        guard !self.encryptText_result.isEmpty else {
            self.errorMessage = "Текст для дешифровки пустой"
            return
        }
        guard !self.keyForCrypt.isEmpty else {
            self.errorMessage = "Ведите ключ для шифрования"
            return
        }
        guard self.checkLanguage() else {
            self.errorMessage = "В введёном тексте присутствуют буквы из другого алфавита"
            return
        }
       
        if self.language == "EN" {
            self.uncryptResult = self.uncryptEN(encryptText_result, keyForCrypt)
        } else {
            self.uncryptResult = self.uncryptRU(encryptText_result, keyForCrypt)
        }
    }
    
    func clearAll(){

        self.language = "EN"
        self.textForCrypt = ""
        self.keyForCrypt = ""
        self.errorMessage = ""
        self.encryptText_result = ""
        self.uncryptResult = ""
        self.uncryptErrorMessage = ""
    }
    
    private func checkLanguage () -> Bool {
        
        if self.language == "EN" {
            for i in textForCrypt {
                if russianLanguage.contains(String(i)) { return false }
            }
        } else {
            for i in textForCrypt {
                if englishLanguage.contains(String(i)) { return false }
            }
        }
        return true
    }
    
    private func checkPassword(){
        var newKey = ""
        
        if language == "EN" {
            let alphabet = englishLanguage + numbers
            for i in keyForCrypt {
                if alphabet.contains(String(i)) {
                    newKey += String(i)
                }
            }
        } else {
            
            let alphabet = russianLanguage + numbers
            
            for i in keyForCrypt {
                if alphabet.contains(String(i)) {
                    newKey += String(i)
                }
            }
        }
        self.keyForCrypt = newKey
    }
}
