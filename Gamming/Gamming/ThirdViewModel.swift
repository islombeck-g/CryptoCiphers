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
    
    func tryCrypt() {
        self.resultIsReady = false
        if checkDataForCrypt() {
           one(textForCrypt, keyForCrypt)
            self.resultIsReady = true
        }
    }
    
    func unCrypt() {
        
        self.uncryptIsReady = false
        
        
        
        self.uncryptIsReady = true
    }
    
    private func one(_ text: String, _ key: String) {
        var normText = text

        while normText.count % key.count != 0 {
            normText += " "
        }
        let bText = stringToBinary(normText)
        let bKey = stringToBinary(key)
        
        let sText = bText.components(separatedBy: " ")
        let sKey = bKey.components(separatedBy: " ")
        
        var newSText = newMap(array: sText, k: sKey.count)
        var newSKey = sKey
        
        var res = [[String]]()
        
        for i in newSText {
            
            var semiRes = [String]()
            
            for (text, key) in zip(i, newSKey) {
                semiRes.append(xorNew(text, key))
            }
            
            newSKey = semiRes
            res.append(semiRes)
        }
        
       
        res.reverse()
        res.append(sKey)
        
//
        var m = ""
        for some in res {
            for j in some {
                m += j + " "
            }
        }

        let endInde = m.index(before: m.endIndex)
        m = String(m[..<endInde])
        self.resultBinarText = m
        self.resultText = binaryToString(m)
        
        
        
//
        
        var encryptRes = [[String]]()
        newSKey = res[0]

        for i in res {
            
            if i == newSKey {
                continue
            }
            
            var encryptResTime = [String]()
            
            for (text, key) in zip(i, newSKey) {
                encryptResTime.append(xorNew(text, key))
            }
            
            newSKey = i
            encryptRes.append(encryptResTime)
        }

        encryptRes.reverse()
        
        var finalRes = ""
        for some in encryptRes {
            for j in some {
                finalRes += j + " "
            }
        }

        let endIndex = finalRes.index(before: finalRes.endIndex)
        finalRes = String(finalRes[..<endIndex])
        
        self.uncryptResultText = binaryToString(finalRes)
        self.uncryptResultBinarText = finalRes
        
    }
    
    func clear() {
        chosenLanguage = "EN"
        textForCrypt = ""
        binaryTextForCrypt = ""
        keyForCrypt = ""
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
    
    private func stringToBinary(_ input: String) -> String {
        guard let data = input.data(using: .utf8) else {
            return ""
        }
        
        let binaryStrings = data.map { byte -> String in
            let binary = String(byte, radix: 2)
            let padding = String(repeating: "0", count: 8 - binary.count)
            return padding + binary
        }
        
        return binaryStrings.joined(separator: " ")
    }
    private func binaryToString(_ binary: String) -> String {
        let components = binary.components(separatedBy: " ")
        
        var bytes = [UInt8]()
        for component in components {
            if let byte = UInt8(component, radix: 2) {
                bytes.append(byte)
            } else {
                return ""
            }
        }
        
        let data = Data(bytes)
        
        if let decodedString = String(data: data, encoding: .utf8) {
            return decodedString
        }
        
        return ""
    }
    private func xorNew(_ str1: String, _ str2: String) -> String {
        
        var result = ""
        for (char1, char2) in zip(str1, str2) {
            let xorResult = (char1 == "1") != (char2 == "1") ? "1" : "0"
            result.append(xorResult)
        }

        return result
    }
    private func newMap(array:[String], k:Int)->[[String]] {
        
        guard k > 0 else {
            return []
        }
        
        var result = [[String]]()
        var counter = 0
        var semiResult = [String]()
        
        for i in array {
            if counter == k {
                result.append(semiResult)
                semiResult.removeAll()
                counter = 0
            }
            semiResult.append(i)
            counter += 1
        }
        
        if !semiResult.isEmpty {
            result.append(semiResult)
        }
        
        return result
    }
    
    
    private func checkDataForCrypt() -> Bool {
        guard self.textForCrypt != "" else {
            self.error = "Введите текст для шифрования"
            return false
        }
        guard self.keyForCrypt != "" else {
            self.error = "Введите ключ для шифрования"
            return false
        }
//        if keyForCrypt.contains(" ") {
//            self.error = "Ключ не должен содержать пробелов"
//            return false
//        }
        guard self.isTextInLanguage(self.textForCrypt, selectedLanguage: self.chosenLanguage) else {
            self.error = "Язык выбран другой, в слове обнаружены буквы из другого алфавита"
            return false
        }
        return true
    }
    func toBinar() {
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
