import Foundation

class Ciepher:VigenereCrack {
    
    var englishLanguage = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var russianLanguage = ["а", "б", "в", "г", "д", "е", "ё", "ж", "з", "и", "й", "к", "л", "м", "н", "о", "п", "р", "с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "ъ", "ы", "ь", "э", "ю", "я", "А", "Б", "В", "Г", "Д", "Е", "Ё", "Ж", "З", "И", "Й", "К", "Л", "М", "Н", "О", "П", "Р", "С", "Т", "У", "Ф", "Х", "Ц", "Ч", "Ш", "Щ", "Ъ", "Ы", "Ь", "Э", "Ю", "Я"]
    
    var numbers = ["0","1", "2", "3", "4", "5", "6", "7", "8", "9"]
    //    не трогать, всё работает!!!!!!!!!!!!!!!!
    func cryptEN(text: String, constant_key: String) -> String {
        var encryptedText = ""
        let alphabet = englishLanguage + numbers
        let key = Array(constant_key)
        
        for i in 0..<text.count {
            let char = text[text.index(text.startIndex, offsetBy: i)]
            
            if alphabet.contains(String(char)) {
                let shift = alphabet.firstIndex(of: String(key[i % key.count]))!
                let charIndex = alphabet.firstIndex(of: String(char))!
                let newIndex = (charIndex + shift) % alphabet.count
                
                encryptedText += String(alphabet[alphabet.index(alphabet.startIndex, offsetBy: newIndex)])
            } else {
                encryptedText += String(char)
            }
        }
        return encryptedText
    }
    func uncryptEN(_ encryptedConstantText: String, _ constant_key:String)-> String {
        var decryptedText = ""
        let alphabet = englishLanguage + numbers
        let encryptedText = encryptedConstantText
        
        let key = Array(constant_key)
        
        for i in 0..<encryptedText.count {
            let char = encryptedText[encryptedText.index(encryptedText.startIndex, offsetBy: i)]
            
            if alphabet.contains(String(char)) {
                let shift = alphabet.firstIndex(of: String(key[i % key.count]))!
                let charIndex = alphabet.firstIndex(of: String(char))!
                var newIndex = (charIndex - shift) % alphabet.count
                
                if newIndex < 0 { newIndex += alphabet.count }
                
                decryptedText += String(alphabet[alphabet.index(alphabet.startIndex, offsetBy: newIndex)])
            } else { decryptedText += String(char) }
        }
        return decryptedText
    }
    func cryptRU(text: String, constant_key: String) -> String {
        var encryptedText = ""
        let alphabet = russianLanguage + numbers
        let key = Array(constant_key)
        
        for i in 0..<text.count {
            
            let char = text[text.index(text.startIndex, offsetBy: i)]
            
            if alphabet.contains(String(char)) {
                let shift = alphabet.firstIndex(of: String(key[i % key.count]))!
                let charIndex = alphabet.firstIndex(of: String(char))!
                let newIndex = (charIndex + shift) % alphabet.count
                
                encryptedText += String(alphabet[alphabet.index(alphabet.startIndex, offsetBy: newIndex)])
            } else { encryptedText += String(char) }
        }
        return encryptedText
    }
    func uncryptRU(_ encryptedConstantText: String, _ constant_key:String)-> String {
        var decryptedText = ""
        let alphabet = russianLanguage + numbers
        let encryptedText = encryptedConstantText
        let key = Array(constant_key)
        
        for i in 0..<encryptedText.count {
            let char = encryptedText[encryptedText.index(encryptedText.startIndex, offsetBy: i)]
            
            if alphabet.contains(String(char)) {
                let shift = alphabet.firstIndex(of: String(key[i % key.count]))!
                let charIndex = alphabet.firstIndex(of: String(char))!
                var newIndex = (charIndex - shift) % alphabet.count
                if newIndex < 0 {
                    newIndex += alphabet.count
                }
                decryptedText += String(alphabet[alphabet.index(alphabet.startIndex, offsetBy: newIndex)])
            } else { decryptedText += String(char) }
        }
        return decryptedText
    }
    //    не трогать, всё работает!!!!!!!!!!!!
    
    
    func crack_en(_ constant_text: String)-> String{
        
        var text = constant_text.lowercased()
        var compare = [Double]()
        
        var keyLength:Int = 0
        
        for n in 1..<constant_text.count {
//            разделёная строка по n элемент
            var me = self.findN_function(&text, n)
//            
            compare.append(self.countForNumber(&me))
            
            if compare.last! > enNumber {
                keyLength = n - 1
                break
            }
        }
        
        let result = splitTextIntoChunks(text: constant_text, number: keyLength)
        
        let combineChunk = combineChunks(chunks: result)
        
        var keyString = ""
        for i in combineChunk {
            
            let dis = findDistance(i, "e", "EN")
            keyString += en[dis]
        }
        
        
        return keyString
    }
}



class VigenereCrack {
//         не трогать, всё работает!!!!!!!!!!!!!!!!
    let alphabetRU = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя1234567890"
    let alphabetEN = "abcdefghijklmnopqrstuvwxyz1234567890"
    let en = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    let ru = ["а", "б", "в", "г", "д", "е", "ё", "ж", "з", "и", "й", "к", "л", "м", "н", "о", "п", "р", "с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "ъ", "ы", "ь", "э", "ю", "я", " "]
    
    let ruNumber = 0.0553
    let enNumber = 0.066
        //    не трогать, всё работает!!!!!!!!!!!!!!!!
    func findDistance(_ text:String, _ char: Character, _ language: String) -> Int {
        
        if language == "EN" {
            //        закидываем все элементы в словарь
            var dic: [Character : Int] = [:]
            for i in text {
                if dic.contains(where: {$0.key == i}) { dic[i]! += 1 }
                else {
                    if en.contains(String(i)) { dic[i] = 1 }
                }
            }
            
            var distance = 0
            
            let maxCharacter = maxKey(&dic)
            var startIndex = en.firstIndex(of: String(maxCharacter))!
            
            var find = false
            var check = false
            
            while find == false {
                
                if Character(en[startIndex]) != char {
                    distance += 1
                    if startIndex == en.count-1 {
                        check = true
                        startIndex = 0
                    } else { startIndex += 1 }
                } else { find = true }
            }
            
            if check == true { return en.count - distance }
            
            return distance
        } else {
            //        закидываем все элементы в словарь
            var dic: [Character : Int] = [:]
            for i in text {
                if dic.contains(where: {$0.key == i}) { dic[i]! += 1 }
                else {
                    if ru.contains(String(i)) { dic[i] = 1 }
                }
            }
            
            var distance = 0
            
            let maxCharacter = maxKey(&dic)
            var startIndex = ru.firstIndex(of: String(maxCharacter))!
            
            var find = false
            var check = false
            
            while find == false {
                if Character(ru[startIndex]) != char {
                    distance += 1
                    if startIndex == ru.count-1 {
                        check = true
                        startIndex = 0
                    } else { startIndex += 1 }
                } else { find = true }
            }
            
            if check == true { return ru.count - distance }
            
            return distance
        }
    }
    private func maxKey(_ dictionary: inout Dictionary<Character, Int>)-> Character {
    
        var maxKey: Character? = nil
        var maxValue: Int? = nil
        
        for (key, value) in dictionary {
            if maxValue == nil || value > maxValue! {
                maxKey = key
                maxValue = value
            }
        }
        
        if let key = maxKey, let _ = maxValue { return key }
        else { return dictionary.first!.key }
    }
//    //    не трогать, всё работает!!!!!!!!!!!!!!!!
    func combineChunks(chunks: [[String]]) -> [String] {
        guard let chunkCount = chunks.first?.count else { return [] }
        
        var combined: [String] = []
        
        for i in 0..<chunkCount {
            var combinedString = ""
            for chunk in chunks {
                if chunk[i] != "-" {
                    combinedString += chunk[i]
                }
            }
            combined.append(combinedString)
        }
        
        return combined
    }
    
    func countForNumber(_ text: inout String) -> Double {
        var letterCount = [Character: Int]()
        
        for char in text {
            if alphabetEN.contains(char) {
                
                if letterCount[char] == nil {
                    letterCount[char] = 1
                } else {
                    letterCount[char]! += 1
                }
            }
        }
        return self.sum(letterCount, text.count)
    }
    //ready
    func findN_function(_ text: inout String, _ n: Int) -> String {
        var result = ""
        
        for (index, char) in text.enumerated() {
            if index % n == 0 {
                result.append(char)
            }
        }
        return result
    }
    
    func sum(_ dictionary: [Character: Int], _ len : Int) -> Double {
        var result = 0.0
        let down:Double = Double(len) * (Double(len) - 1)
        
        for value in dictionary.values {
            let up:Double = Double(value) * (Double(value) - 1)
            result += up/down
        }
        return result
    }
    
    func splitTextIntoChunks(text: String, number: Int) -> [[String]] {
        var chunks: [[String]] = []
        
        for i in stride(from: 0, to: text.count, by: number) {
            let start = text.index(text.startIndex, offsetBy: i)
            let end = text.index(start, offsetBy: number, limitedBy: text.endIndex) ?? text.endIndex
            var chunk = Array(text[start..<end]).map { String($0) }
            
            if chunk.count < number {
                let deficit = number - chunk.count
                chunk += Array(repeating: "-", count: deficit).map { String($0) }
            }
            chunks.append(chunk)
        }
        
        return chunks
    }
}
