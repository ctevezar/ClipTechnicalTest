//
//  String+Localizable.swift
//  ClipTechnicalTest
//
//  Created by Carlos Tevez on 07/06/2024.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
