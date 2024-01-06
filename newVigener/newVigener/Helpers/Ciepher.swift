import Foundation

class Ciepher {
    func cryptEN(constantText: String, constantKey: String)->String {
        var result = ""
        let arrayOfText = Array(constantText)
        var arrayOfKey: [Character] = []
        
        while arrayOfText.count > arrayOfKey.count {
            arrayOfKey += Array(constantKey)
        }
        
        let alphabet = englishLanguage + numbers + " "
        
        for i in arrayOfText.indices {
            guard let indexF = alphabet.firstIndex(of: arrayOfText[i]) else { result.append(arrayOfText[i]);continue }
            let indexS = alphabet.firstIndex(of: arrayOfKey[i])!
            
            var number = indexS + indexF
            if number >= 63 {
                number = number - 63
            }
            print("\(arrayOfText[i]) _ \(number)")
            result.append(alphabet[number])
        }
        
        return result
    }
    func unCryptEN(constantText: String, constantKey:String)->String{
        var result = ""
        let arrayOfText = Array(constantText)
        var arrayOfKey: [Character] = []
        
        while arrayOfText.count > arrayOfKey.count {
            arrayOfKey += Array(constantKey)
        }
        
        let alphabet = englishLanguage + numbers + " "
        
        for i in arrayOfText.indices {
            guard let indexF = alphabet.firstIndex(of: arrayOfText[i]) else { result.append(arrayOfText[i]);continue }
            let indexS = alphabet.firstIndex(of: arrayOfKey[i])!
            
            var number = indexF - indexS
            if number < 0 {
                number = 63 + number
            }
            result.append(alphabet[number])
        }
        
        return result
        
    }
}
