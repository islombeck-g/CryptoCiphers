import Foundation
import BigNumber

class Ciephers {
    
    var en = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    var ru = ["а", "б", "в", "г", "д", "е", "ё", "ж", "з", "и", "й", "к", "л", "м", "н", "о", "п", "р", "с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "ъ", "ы", "ь", "э", "ю", "я", " "]
    
    func caesarCipherEN(_ text: String, _ shift: Int) -> String {
        
        let alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
        var r = ""
        
        for character in text {
            if let index = alphabet.firstIndex(of: String(character)) {
                
                var shiftedIndex = index + shift
                
                while shiftedIndex < 0 { shiftedIndex += alphabet.count }
                
                while shiftedIndex >= alphabet.count { shiftedIndex -= alphabet.count }
                
                r += alphabet[shiftedIndex]
                
            } else { r += String(character) }
        }
        
        return r
    }
    func caesarCipherRU(_ text: String, _ shift: Int) -> String {
        
        let alphabet =  ["а", "б", "в", "г", "д", "е", "ё", "ж", "з", "и", "й", "к", "л", "м", "н", "о", "п", "р", "с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "ъ", "ы", "ь", "э", "ю", "я", " "]
        var result = ""
        
        for character in text {
            if let index = alphabet.firstIndex(of: String(character)) {
              
                var shiftedIndex = index + shift
                
                while shiftedIndex < 0 { shiftedIndex += alphabet.count }
                
                while shiftedIndex >= alphabet.count { shiftedIndex -= alphabet.count }
                
                result += alphabet[shiftedIndex]
            } else { result += String(character) }
        }
        
        return result
    }
    
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
    
    func keyToInt(_ key: String, _ language: String) -> Int {
    
        let someKey = BInt(key)
        var rightKey = BInt("0")
        
        if language == "RU" { rightKey = someKey! % BInt("\(ru.count)")! }
        else { rightKey = someKey! % BInt("\(en.count)")! }
        
        var i = 0
        
        if rightKey! == BInt("0")!{ return 0 }
        else if rightKey! > BInt("0")! {
            
            while rightKey! != BInt("0")! {
                i += 1
                rightKey! -= BInt("1")!
            }
            
            return i
        }
        else {
            while rightKey! != BInt("0")! {
                i -= 1
                rightKey! += BInt("1")!
            }
            
            return i
        }
    }
    func containsOnlyDigits(_ input: inout String) -> Bool {
        
        if input.first == "+"{
        
            input.removeFirst()
            if input.first == "0" { return false }
        } else if input.first == "-" {
            
            var me = input
            me.removeFirst()
            
            if input.first == "0" { return false }
            
            for character in me {
                if !character.isNumber { return false }
            }
            
            return true
        }
        for character in input {
            if !character.isNumber { return false }
        }
        
        return true
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
}
