//
//  ElementSelectionnable.swift
//
//
//  Created by Thomas Le Bonnec on 01/12/2023.
//

import Foundation

public class ElementSelectionnable: Selectionnable {
    public let id = UUID()
    public let clé: String
    
    public init(clé: String) {
        self.clé = clé
    }
    
    
    public static func == (lhs: ElementSelectionnable, rhs: ElementSelectionnable) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
