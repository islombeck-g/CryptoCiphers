import Foundation

class Ciepher {

    
    func firstMCrypt(_ cText:String, _ cKey:String) -> (String, String) {

        var newK = fillKey(cText, cKey)
        
        let bText = stringToBinary(cText)
        let bKey = stringToBinary(newK)
        //
        let sepT = bText.components(separatedBy: " ")
        let sepK = bKey.components(separatedBy: " ")

        let encryptedBinaryText = applyXOR(sepT, sepK)
        print("encryptedBinartext = \n\(encryptedBinaryText)\n")
        
        let newS = encryptedBinaryText.joined(separator: " ")
        print("newS = \n\(newS)\n")
        //return String, Binar
        return (binaryToString(newS), newS)
    }
    
    func firstMUnCrypt(_ cText:String, _ cKey:String) -> (String, String) {
        print("cText = \n\(cText)\n")
        print("cKey = \n\(cKey)\n")
        
        let newK = fillKey(cText, cKey)
        let bKey = stringToBinary(newK)
        
        let sepT = cText.components(separatedBy: " ")
        let sepK = bKey.components(separatedBy: " ")
        
        let decrypted = applyXOR(sepT, sepK)
        
        let newS = decrypted.joined(separator: " ")
        
        //return String, Binar
        return (binaryToString(newS), newS)
        
    }
    
    func secondMCrypt(_ cText: String, _ cKey: String) -> (String, String) {
        
        let bText = stringToBinary(cText)
        
        let sepT = bText.components(separatedBy: " ")
        let sepK = cKey.components(separatedBy: " ")
        
        let encryptedBinaryText = applyXOR(sepT, sepK)
        print("encryptedBinartext = \n\(encryptedBinaryText)\n")
        
        let newS = encryptedBinaryText.joined(separator: " ")
        print("newS = \n\(newS)\n")
        //return String, Binar
        return (binaryToString(newS), newS)
    }
    
    func secondMUnCrypt(_ cText: String, _ cKey: String ) -> (String, String) {
        let sepT = cText.components(separatedBy: " ")
        let sepK = cKey.components(separatedBy: " ")
        
        let decrypted = applyXOR(sepT, sepK)
        
        let newS = decrypted.joined(separator: " ")
        
        //return String, Binar
        return (binaryToString(newS), newS)
    }
    
    func randKey(_ count: Int) -> String {
        var hexDigits = ""

        for _ in 0..<count {
            hexDigits += "0000000011111111"
        }
        print(hexDigits.count/2)

        var shuffled = hexDigits.shuffled()

        var newText = ""
        var counter = 0
        for i in shuffled {
            if counter == 16 {
                newText += " "
                counter = 0
            }
            newText += String(i)
            counter += 1
        }
        if newText.last == " " {
            newText.removeLast()
        }
     
        return newText
    }
    private func xor(_ a: Bool, _ b: Bool) -> Bool {
        return (a || b) && !(a && b)
    }
    func applyXOR(_ binaryText: [String], _ binaryKey: [String]) -> [String] {
        var encryptedBinaryText = [String]()

        for (index, binaryBlock) in binaryText.enumerated() {
            var encryptedBlock = ""

            for (charIndex, char) in binaryBlock.enumerated() {
                let textBit = char == "1"
    //            let keyBit = binaryKey[index][charIndex] == "1"
                let keyBit = binaryKey[index][binaryKey[index].index(binaryKey[index].startIndex, offsetBy: charIndex)] == "1"

                let resultBit = xor(textBit, keyBit)

                encryptedBlock += resultBit ? "1" : "0"
            }

            encryptedBinaryText.append(encryptedBlock)
        }

        return encryptedBinaryText
    }
    //переводы строк
    func stringToBinary(_ input: String) -> String {
        guard let data = input.data(using: .utf16) else {
            return ""
        }
        let binaryStrings = data.map { byte -> String in
            let binary = String(byte, radix: 2)
            let padding = String(repeating: "0", count: 16 - binary.count)
            return padding + binary
        }
        return binaryStrings.joined(separator: " ")
    }
    func binaryToString(_ binary: String) -> String {
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
        if let decodedString = String(data: data, encoding: .utf16) {
            return decodedString
        }
        return ""
    }
    // увеличивает длину ключа
    func fillKey(_ text: String, _ key: String) -> String {
        var newKey = ""
        while newKey.count < text.count {
            newKey += key
        }
        return String(newKey.prefix(text.count))
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
}



//------------
//import Foundation
//
//class Ciepher {
//
//    
//    func firstMCrypt(_ cText:String, _ cKey:String) -> (String, String) {
//
//        var newK = fillKey(cText, cKey)
//        
//        let bText = stringToBinary(cText)
//        let bKey = stringToBinary(newK)
//        //
//        let sepT = bText.components(separatedBy: " ")
//        let sepK = bKey.components(separatedBy: " ")
//
//        let encryptedBinaryText = applyXOR(sepT, sepK)
//        print("encryptedBinartext = \n\(encryptedBinaryText)\n")
//        
//        let newS = encryptedBinaryText.joined(separator: " ")
//        print("newS = \n\(newS)\n")
//        //return String, Binar
//        return (binaryToString(newS), newS)
//    }
//    
//    func firstMUnCrypt(_ cText:String, _ cKey:String) -> (String, String) {
//        print("cText = \n\(cText)\n")
//        print("cKey = \n\(cKey)\n")
//        
//        let newK = fillKey(cText, cKey)
//        let bKey = stringToBinary(newK)
//        
//        let sepT = cText.components(separatedBy: " ")
//        let sepK = bKey.components(separatedBy: " ")
//        
//        let decrypted = applyXOR(sepT, sepK)
//        
//        let newS = decrypted.joined(separator: " ")
//        
//        //return String, Binar
//        return (binaryToString(newS), newS)
//        
//    }
//    
//    func secondMCrypt(_ cText: String, _ cKey: String) -> (String, String) {
//        
//        let bText = stringToBinary(cText)
//        
//        let sepT = bText.components(separatedBy: " ")
//        let sepK = cKey.components(separatedBy: " ")
//        
//        let encryptedBinaryText = applyXOR(sepT, sepK)
//        print("encryptedBinartext = \n\(encryptedBinaryText)\n")
//        
//        let newS = encryptedBinaryText.joined(separator: " ")
//        print("newS = \n\(newS)\n")
//        //return String, Binar
//        return (binaryToString(newS), newS)
//    }
//    
//    func secondMUnCrypt(_ cText: String, _ cKey: String ) -> (String, String) {
//        let sepT = cText.components(separatedBy: " ")
//        let sepK = cKey.components(separatedBy: " ")
//        
//        let decrypted = applyXOR(sepT, sepK)
//        
//        let newS = decrypted.joined(separator: " ")
//        
//        //return String, Binar
//        return (binaryToString(newS), newS)
//    }
//    
//    func randKey(_ count: Int) -> String {
//
//        var zerOnes = ""
//        for _ in 0..<count{
//            zerOnes += "1010101"
//        }
//        print(zerOnes.count)
//        print(zerOnes)
//        var shuffled = zerOnes.shuffled()
//        print(shuffled)
//
//        var newText = ""
//        var counter = 0
//        for i in shuffled {
//            if counter == 7 {
//                newText += " "
//                counter = 0
//            }
//            newText += String(i)
//            counter += 1
//        }
//        return newText
//    }
//    
//    
//    private func xor(_ a: Bool, _ b: Bool) -> Bool {
//        return (a || b) && !(a && b)
//    }
//    
//    func applyXOR(_ binaryText: [String], _ binaryKey: [String]) -> [String] {
//        var encryptedBinaryText = [String]()
//
//        for (index, binaryBlock) in binaryText.enumerated() {
//            var encryptedBlock = ""
//
//            for (charIndex, char) in binaryBlock.enumerated() {
//                let textBit = char == "1"
//    //            let keyBit = binaryKey[index][charIndex] == "1"
//                let keyBit = binaryKey[index][binaryKey[index].index(binaryKey[index].startIndex, offsetBy: charIndex)] == "1"
//
//                let resultBit = xor(textBit, keyBit)
//
//                encryptedBlock += resultBit ? "1" : "0"
//            }
//
//            encryptedBinaryText.append(encryptedBlock)
//        }
//
//        return encryptedBinaryText
//    }
//    //переводы строк
//    func stringToBinary(_ input: String) -> String {
//        guard let data = input.data(using: .utf8) else {
//            return ""
//        }
//        let binaryStrings = data.map { byte -> String in
//            let binary = String(byte, radix: 2)
//            let padding = String(repeating: "0", count: 8 - binary.count)
//            return padding + binary
//        }
//        
//        return binaryStrings.joined(separator: " ")
//    }
//    func binaryToString(_ binary: String) -> String {
//        let components = binary.components(separatedBy: " ")
//
//        var bytes = [UInt8]()
//        for component in components {
//            if let byte = UInt8(component, radix: 2) {
//                bytes.append(byte)
//            } else {
//                return ""
//            }
//        }
//        let data = Data(bytes)
//        if let decodedString = String(data: data, encoding: .utf8) {
//            return decodedString
//        }
//        return ""
//    }
//
//
//    
//    // увеличивает длину ключа
//    func fillKey(_ text: String, _ key: String) -> String {
//        var newKey = ""
//        while newKey.count < text.count {
//            newKey += key
//        }
//        return String(newKey.prefix(text.count))
//    }
//    
//    private func newMap(array:[String], k:Int)->[[String]]{
//        
//        guard k > 0 else {
//            return []
//        }
//        
//        var result = [[String]]()
//        var counter = 0
//        var semiResult = [String]()
//        
//        for i in array {
//            if counter == k {
//                result.append(semiResult)
//                semiResult.removeAll()
//                counter = 0
//            }
//            semiResult.append(i)
//            counter += 1
//        }
//        
//        if !semiResult.isEmpty {
//            result.append(semiResult)
//        }
//            
//        return result
//        
//    }
//}
//
