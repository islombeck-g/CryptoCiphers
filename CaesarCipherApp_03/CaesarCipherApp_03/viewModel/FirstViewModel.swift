import Foundation
import BigNumber

class FirstViewModel:Ciephers, ObservableObject {
    
    @Published var language: String = "EN"
    
    @Published var result = ""
    @Published var errorMessage = ""
    @Published var resultIsReady = false
    
    @Published var uncryptResult = ""
    @Published var uncryptErrorMessage = ""
    @Published var uncryptIsReady = false
   
    private func checkTextToLang (text: String)-> Bool {
        if language == "EN" {
            for i in text {
                if ru.contains(String (i)) && String(i) != " " { return false }
            }
        } else {
            for i in text {
                if en.contains(String (i)) && String(i) != " " { return false }
            }
        }
        return true
    }
    
    func uncrypt(_ st: String, nkey: String){
       
        var key = nkey
        self.uncryptErrorMessage = ""
        self.uncryptIsReady = false
        self.uncryptResult = ""
        
        if key.isEmpty {
            self.uncryptErrorMessage = "Поле ключа для расшифровки пустое"
            return
        }
        
        if st.isEmpty {
            self.uncryptErrorMessage = "Поле текста для расшифровки пустое"
            return
        }
        
        let s = st.lowercased()
        
        guard checkTextToLang(text: s) else {
            self.uncryptErrorMessage = "Поле текста содержит букву(ы) из другого алфавита"
            return
        }
        
        if containsOnlyDigits(&key) {
        
            if key.first == "-" { key.removeFirst() }
            else { key = "-" + key }
            
            let normalKey = self.keyToInt(key, language)
            
            if language == "RU" { self.uncryptResult = caesarCipherRU(s, normalKey) }
            else { self.uncryptResult = caesarCipherEN(s, normalKey) }
            
            self.uncryptIsReady = true
            
        } else { self.errorMessage = "Ошибка, клчю не правильный в расшифровки" }
    }
    
    func crypt (_ st : String, key1: String){
       
        var key = key1
        self.result = ""
        self.errorMessage = ""
        self.resultIsReady = false
        
        if key.isEmpty {
            self.errorMessage = "Поле ключа пустое для шифрования"
            return
        }
        
        if st.isEmpty {
            self.errorMessage = "Поле текста пустое для шифрования"
            return
        }
        
        let s = st.lowercased()
        
        guard checkTextToLang(text: s) else {
            self.errorMessage = "Поле текста содержит букву(ы) из другого алфавита"
            return
        }
        
        if containsOnlyDigits(&key) {
            let normalKey = self.keyToInt(key, language)
    
            if language == "RU" { self.result = caesarCipherRU(s, normalKey) }
            else { self.result = caesarCipherEN(s, normalKey) }
            self.resultIsReady = true
        } else { self.errorMessage = "Ошибка, клчю не правильный для шифрования" }
    }
}
