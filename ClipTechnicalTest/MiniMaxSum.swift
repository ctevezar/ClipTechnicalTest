//
//  MiniMaxSum.swift
//  ClipTechnicalTest
//
//  Created by María Markosich on 16/01/2024.
//

import Foundation

final class MiniMaxSum {

    func miniMaxSum(arr: [Int]) -> String {
        
        let minNumber = getMinNumber(from: arr)
        let maxNumber = getMaxNumber(from: arr)
        
        return resultsToString(max: maxNumber, min: minNumber)
    }
    
    private func resultsToString(max: String, min: String) -> String {
        "\(max) \(min)"
    }
    
    private func getMinNumber(from arr: [Int]) -> String {
        let minNumber = removeMinorNumber(in: arr)
        
        return toSumAllElements(in: minNumber).stringValue
    }
    
    private func getMaxNumber(from arr: [Int]) -> String {
        let minNumber = removeLargerNumber(in: arr)
        
        return toSumAllElements(in: minNumber).stringValue
    }
    
    private func removeLargerNumber(in arr: [Int]) -> [Int] {
        var numbers = arr
        
        if let maxValue = numbers.max() {
            numbers.removeAll { $0 == maxValue }
        }
        
        return numbers
    }
    
    private func removeMinorNumber(in arr: [Int]) -> [Int] {
        var numbers = arr
        if let minValue = numbers.min() {
            numbers.removeAll { $0 == minValue }
        }
        
        return numbers
    }
    
    private func toSumAllElements(in numbers: [Int]) -> Int {
        var result = 0
        
        for number in numbers {
            result += number
        }
        
        return result
    }
}

