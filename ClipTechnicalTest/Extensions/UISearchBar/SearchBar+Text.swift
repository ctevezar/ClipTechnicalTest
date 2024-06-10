//
//  SearchBar+Text.swift
//  ClipTechnicalTest
//
//  Created by Carlos Tevez on 07/06/2024.
//

import UIKit

extension UISearchBar {
    var isTextEmpty: Bool {
        return text?.isEmpty ?? true
    }
}
