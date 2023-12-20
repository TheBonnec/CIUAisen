//
//  File.swift
//  
//
//  Created by Thomas Le Bonnec on 20/12/2023.
//

import Foundation


extension String {
    func localized(withComment comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? "")
    }
}
