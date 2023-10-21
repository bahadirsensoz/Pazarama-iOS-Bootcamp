
import Foundation

class RomanNumbers {
    let number: String
    
    init(number: String) {
        self.number = number
    }
    
    private func isValidNumber(number: String) -> Bool {
        
        if number.range(of: "^M{0,3}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$", options: .regularExpression) != nil {
            return true
        }
        return false
    }
    
    func romanToInt(_ s: String) -> Int {
        let romanDict: [Character: Int] = ["I": 1, "V": 5, "X": 10, "L": 50, "C": 100, "D": 500, "M": 1000]
        
        var result = 0
        var previousValue = 0
        
        if isValidNumber(number: s) {
            for char in s {
                if let value = romanDict[char] {
                    if value > previousValue {
                        result += value - (2 * previousValue)
                    } else {
                        result += value
                    }
                    previousValue = value
                }
            }
            return result
        }
        
        return -1
    }
}
