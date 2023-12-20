//
//  LienDeNavigateur.swift
//
//
//  Created by Thomas Le Bonnec on 01/12/2023.
//

import SwiftUI


public struct LienDeNavigateur: Identifiable {
    public let id = UUID()
    let lienDeNavigateur: any Lien
    
    
    public init(clé: String, destination: Page) {
        let lienGénérique = LienGenerique(clé: clé)
        self.lienDeNavigateur = LienDeNavigateurPrimitif(lien: lienGénérique, destination: destination)
    }
    
    
    
    public var lien: any Selectionnable {
        return lienDeNavigateur.lien
    }
    
    public var clé: String {
        return lien.clé
    }
    
    public var destination: Page {
        lienDeNavigateur.destination as! Page   // Possible car l'init n'accepte que des types Page en argument
    }
}





struct LienDeNavigateurPrimitif<T: Selectionnable>: Lien {
    let lien: T
    let destination: Page
}
