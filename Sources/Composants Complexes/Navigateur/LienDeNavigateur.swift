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
    
    
    public init<Destination: View>(clé: String, destination: Destination) {
        let lienGénérique = LienGenerique(clé: clé)
        self.lienDeNavigateur = LienDeNavigateurPrimitif(lien: lienGénérique, destination: destination)
    }
    
    
    
    public var lien: any Selectionnable {
        return lienDeNavigateur.lien
    }
    
    public var clé: String {
        return lien.clé
    }
    
    public var destination: any View {
        lienDeNavigateur.destination
    }
}





struct LienDeNavigateurPrimitif<T: Selectionnable, U: View>: Lien {
    let lien: T
    let destination: U
}
