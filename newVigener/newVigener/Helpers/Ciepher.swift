import Foundation

class Ciepher {
    func encryptText(_ ConstText:String, _ ConstKey:String, chosenLanguage: Languages) ->String {
        
        
        
        let newKey = Array(getRepeatedKey(ConstText.count, ConstKey))
        
        let alphabet = chosenLanguage == .english ? englishLanguage + numbers : russianLanguage + numbers
        
        let arrayOfText = Array(ConstText)
        
        var result = ""
        
        for i in arrayOfText.indices {
            
            guard let indexF = alphabet.firstIndex(of: arrayOfText[i]) else {
                result.append(arrayOfText[i]); continue }
            
            let indexS = alphabet.firstIndex(of: newKey[i])!
            
            var number = indexS + indexF
            if number >= alphabet.count {
                number = number - alphabet.count
            }
            result.append(alphabet[number])
        }
        return result
    }
    func decrypt(_ ConstText:String, _ ConstKey:String, chosenLanguage: Languages) -> String {
        let alphabet = chosenLanguage == .english ? englishLanguage + numbers : russianLanguage + numbers
        var result = ""
        let arrayOfText = Array(ConstText)
        
        let newKey = Array(getRepeatedKey(ConstText.count, ConstKey))
        
        
        for i in arrayOfText.indices {
            guard let indexF = alphabet.firstIndex(of: arrayOfText[i]) else {
                result.append(arrayOfText[i]); continue }
            let indexS = alphabet.firstIndex(of: newKey[i])!
            
            var number = indexF - indexS
            if number < 0 {
                number = alphabet.count + number
            }
            result.append(alphabet[number])
        }
        
        return result
    }
    private func getRepeatedKey(_ textSize:Int, _ key:String) -> String {
        if textSize <= key.count {
            return key
        }
        let reminder = textSize % key.count
        let count = textSize / key.count
        let newKey = String(repeating: key, count: count) + key.prefix(reminder)
        return newKey
    }
}
