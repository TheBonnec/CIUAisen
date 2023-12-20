//
//  Bouton.swift
//
//
//  Created by Thomas Le Bonnec on 27/11/2023.
//

import SwiftUI


@available(macOS 13, iOS 16, *)
public struct Bouton: View {
    
    /* ----- Attributs ----- */
    
    var type: TypeBouton
    var label: String
    var action: () -> ()
    
    var couleurDeFond: Color
    var couleurDeFace: Color
    
    
    
    /* ----- Inits ----- */
    
    public init(type: TypeBouton = .primaire, label: String, action: @escaping () -> ()) {
        self.type = type
        self.label = label
        self.action = action
        
        switch type {
        case .primaire:
            self.couleurDeFond = Color.teinteDeBase
            self.couleurDeFace = Color.blancConstant
        case .secondaire:
            self.couleurDeFond = Color.teinteDeBaseSecondaire
            self.couleurDeFace = Color.teinteDeBaseTertiaire
        case .destructeurPrimaire:
            self.couleurDeFond = Color.teinteAvertissement
            self.couleurDeFace = Color.blancConstant
        case .destructeurSecondaire:
            self.couleurDeFond = Color.teinteAvertissementSecondaire
            self.couleurDeFace = Color.teinteAvertissementTertiaire
        }
    }
    
    
    
    /* ----- Vues ----- */
    
    public var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(label.localized())
                .foregroundStyle(couleurDeFace)
                //.frame(height: 30)
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(couleurDeFond)
                .cornerRadius(4)
        })
        .buttonStyle(PlainButtonStyle())
    }
}





public enum TypeBouton {
    case primaire, secondaire, destructeurPrimaire, destructeurSecondaire
}





#Preview {
    Bouton(label: "Bouton Primaire") {
        print()
    }
}
