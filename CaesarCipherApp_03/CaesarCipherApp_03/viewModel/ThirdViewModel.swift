
import Foundation

class ThirdViewModel:Ciephers, ObservableObject {
    
    @Published var language: String = "EN"
    
    @Published var result = ""
    @Published var errorMessage = ""
    @Published var resyltIsReady = false
    
    @Published var rightKey:Int = 0
    
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
    
    func tryCrack(_ constantText: String, _ charStringOriginal: String) {
        self.result = ""
        self.errorMessage = ""
        self.resyltIsReady = false
        
        let charString = charStringOriginal.lowercased()
        
        guard !constantText.isEmpty && !charString.isEmpty else {
            self.errorMessage = "Ошибка, не введены все требуемые поля"
            return
        }
        
        guard let char = charString.first else{
            self.errorMessage = "Ошибка в конвертировании в символ ключа"
            return
        }
        
        guard checkTextToLang(text: constantText) else {
            self.errorMessage = "Поле текста содержит букву(ы) из другого алфавита"
            return
        }
        
        let text = constantText.lowercased()
        
        if language == "EN" {

            guard en.contains(String(char)) else {
                self.errorMessage = "Такого часто встречающего символа в словаре нет"
                return
            }

            let dis = findDistance(text, char, "EN")
            self.rightKey = dis
            
            self.result = caesarCipherEN(text, dis)

            if !result.isEmpty { self.resyltIsReady = true }
            else { self.errorMessage = "Непонятная ошибка" }
            
        } else {
            
            guard ru.contains(String(char)) else {
                self.errorMessage = "Такого часто встречающего символа в словаре нет"
                return
            }
            
            let dis = findDistance(text, char, "RU")
            self.rightKey = dis
            
            self.result = caesarCipherRU(text, dis)
            
            if !result.isEmpty { self.resyltIsReady = true }
            else { self.errorMessage = "Непонятная ошибка" }
        }
    }
}
