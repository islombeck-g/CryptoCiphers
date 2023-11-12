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
        guard let data = input.data(using: .utf8) else {
            return ""
        }
        
        let binaryString = data.map { byte in
            return String(byte, radix: 2, uppercase: false)
        }.joined(separator: " ")
        
        return binaryString
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

        if let decodedString = String(data: data, encoding: .utf8) {
            return decodedString
        }

        return ""
    }
    
    // увеличивает длину ключа
    func fillKey(_ text: String, _ key:String) -> String {
        var newKey = ""
        while newKey.count < text.count {
            newKey += key
        }
        return newKey
    }
    
    private func newMap(array:[String], k:Int)->[[String]]{
        
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
