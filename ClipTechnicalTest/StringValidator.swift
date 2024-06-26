//
//  StringValidator.swift
//  ClipTechnicalTest
//
//  Created by María Markosich on 16/01/2024.
//

import Foundation

final class StringValidator {
    func isValid(s: String) -> String {
        return validate(s: s) ? "YES" : "NO"
    }
    
    private func validate(s: String) -> Bool {
        let characters = Set(s) // Hago un array con los elementos sin repetir
        let charRepeat = count(char: characters.first, in: s)
        
        for character in characters {
            let count = count(char: character, in: s)
            let countMinusOne = count - 1

            let isCountDifferentFromCharRepeat = charRepeat != count
            let isCharRepeatDifferentFromCountMinusOneAndNotZero = charRepeat != countMinusOne && countMinusOne != 0

            if isCountDifferentFromCharRepeat && isCharRepeatDifferentFromCountMinusOneAndNotZero {
               return false
            }
        }
        
        return true
    }
    
    private func count(char: Character?, in s: String) -> Int {
        s.filter{ $0 == char }.count
    }
}
