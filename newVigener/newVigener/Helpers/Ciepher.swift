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
    
    func hack1(_ ConstText:String, me:String, chosenLanguage: Languages) ->(String, String) {
        let alphabet = chosenLanguage == .english ? englishLanguage + numbers: russianLanguage + numbers
        let languageIndex = chosenLanguage == .english ? 0.0644 : 0.0553
//        let constIndex = chosenLanguage == .english ? 0.0553 : 0.0644
        
        var previousIndex = 0
        var i = 1
        var currentIndex = 0.0

        while Double(currentIndex) < languageIndex && Double(i) <= Double(alphabet.count) {
            var frequencyList = Array(repeating: 0, count: alphabet.count)
            
            for j in stride(from: 0, to: ConstText.count, by: i) {
                let charIndex = alphabet.firstIndex(of: ConstText[ConstText.index(ConstText.startIndex, offsetBy: j)])!
                frequencyList[charIndex] += 1
            }
            
            currentIndex = 0.0

            let totalSum = Double(frequencyList.reduce(0, +))
            let totalSumMinusOne = totalSum - 1

            for frequency in frequencyList {
                let numerator = Double(frequency * (frequency - 1))
                let denominator = totalSum * totalSumMinusOne
                currentIndex += numerator / denominator
            }

            previousIndex = i
            i += 1
        }

        let numberOfRows = (ConstText.count / previousIndex) + 1
        var textIndexMatrix = Array(repeating: Array(repeating: "", count: previousIndex), count: numberOfRows)



        for i in 0..<textIndexMatrix.count {
            for j in 0..<textIndexMatrix[i].count {
                let index = (i * previousIndex) + j
                if index < ConstText.count {
                    textIndexMatrix[i][j] = String(ConstText[ConstText.index(ConstText.startIndex, offsetBy: index)])
                }
            }
        }

        var frequencyNormalText = Array(repeating: 0, count: alphabet.count)

        var counterBook = 0

        for char in me {
            let charLower = char.lowercased()
            if let charIndex = alphabet.firstIndex(of: Character(charLower)) {
                counterBook += 1
                frequencyNormalText[charIndex] += 1
            }
        }

        var frequencyLengthKeysList: [[Double]] = []

        for j in 0..<textIndexMatrix[0].count {
            var currentFrequencyAnalysis = Array(repeating: 0.0, count: alphabet.count)
            var frequencyCounter = 0

            for i in 0..<textIndexMatrix.count {
                if !textIndexMatrix[i][j].isEmpty {
                    if let charIndex = alphabet.firstIndex(of: Character(textIndexMatrix[i][j].lowercased())) {
                        currentFrequencyAnalysis[charIndex] += 1
                        frequencyCounter += 1
                    }
                }
            }

            for x in 0..<currentFrequencyAnalysis.count {
                currentFrequencyAnalysis[x] /= Double(frequencyCounter)
            }

            frequencyLengthKeysList.append(currentFrequencyAnalysis)
        }

        
        var keyDifferenceList: [Int] = []
        var keyString = ""

        for i in 0..<frequencyLengthKeysList.count {
            let maxIndexInLengthKeys = frequencyLengthKeysList[i].firstIndex(of: frequencyLengthKeysList[i].max()!)!
            let maxIndexInNormalText = frequencyNormalText.firstIndex(of: frequencyNormalText.max()!)!

            var difference = maxIndexInLengthKeys - maxIndexInNormalText
            if difference < 0 {
                difference = alphabet.count + difference
            }
            keyDifferenceList.append(difference)
            keyString += String(alphabet[difference])
        }

        print("key___")
        print(keyString, keyDifferenceList, previousIndex)
        print("key___")
        // Assuming entry_key_hack is a UITextField or similar
        let key = keyString
        
        keyString = getRepeatedKey(ConstText.count, keyString)
        return (decrypt(ConstText, keyString, chosenLanguage: chosenLanguage), key)
    }

}
