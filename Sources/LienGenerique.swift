//
//  LienGenerique.swift
//
//
//  Created by Thomas Le Bonnec on 01/12/2023.
//

import Foundation

class LienGenerique: Selectionnable {
    let id = UUID()
    let clé: String
    
    required init() {
        self.clé = "Random"
    }
    
    init(clé: String) {
        self.clé = clé
    }
    
    
    static func == (lhs: LienGenerique, rhs: LienGenerique) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
