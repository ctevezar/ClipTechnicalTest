//
//  SherlockAndValidString.tests.swift
//  magus_ios
//
//  Created by Maria Agustina Markosich on 25/08/2022.
//

import Foundation

import XCTest
@testable import ClipTechnicalTest

class StringValidator_tests: XCTestCase {

    func test_validation() {
        XCTAssertEqual("YES", StringValidator().isValid(s: "aabbc"))
    }

}
