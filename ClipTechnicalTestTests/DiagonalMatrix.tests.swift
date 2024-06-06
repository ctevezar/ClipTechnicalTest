//
//  DiagonalMatrix.tests.swift
//  magus_iosTests
//
//  Created by Maria Agustina Markosich on 03/07/2022.
//

import Foundation

import XCTest
@testable import ClipTechnicalTest

class MiniMaxSum_tests: XCTestCase {

    func test_minimax(){
        let minimax = MiniMaxSum()
        let result = minimax.miniMaxSum(arr: [256741038,623958417,467905213,714532089,938071625])
        XCTAssertEqual("2063136757 2744467344", result)

    }

    func test_minimax2(){
        let minimax = MiniMaxSum()
        let result = minimax.miniMaxSum(arr: [5,1,9,20,12])
        XCTAssertEqual("27 46", result)
    }
}
