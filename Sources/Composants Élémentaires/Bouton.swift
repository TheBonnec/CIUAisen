//
//  Bouton.swift
//
//
//  Created by Thomas Le Bonnec on 27/11/2023.
//

import SwiftUI


public struct Bouton: View {
    
    /* ----- Attributs ----- */
    
    @EnvironmentObject private var config: ConfigurationAisen
    
    private var type: TypeBouton
    private var label: String
    private var action: () -> ()
    
    @State private var couleurDeFace: Color
    @State private var couleurDeFond: Color
    
    
    
    /* ----- Inits ----- */
    
    public init(type: TypeBouton = .primaire, label: String, action: @escaping () -> ()) {
        self.type = type
        self.label = label
        self.action = action
        self.couleurDeFond = Color.clear
        self.couleurDeFace = Color.clear
    }
    
    
    public init(label: String, couleurDeFace: Color, couleurDeFond: Color, action: @escaping () -> ()) {
        self.type = .custom
        self.label = label
        self.action = action
        self.couleurDeFace = couleurDeFace
        self.couleurDeFond = couleurDeFond
    }
    
    
    
    /* ----- Vues ----- */
    
    public var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(label.localized())
                .foregroundStyle(couleurDeFace)
                .padding(.vertical, 12)
                .padding(.horizontal, 20)
                .background(couleurDeFond)
                .cornerRadius(4)
        })
        .buttonStyle(PlainButtonStyle())
        .onAppear {
            définirCouleurs()
        }
    }
    
    
    
    /* ----- Fonctions ----- */
    
    func définirCouleurs() {
        switch self.type {
        case .primaire:
            self.couleurDeFond = config.teinteDeBase
            self.couleurDeFace = config.blancConstant
        case .secondaire:
            self.couleurDeFond = config.teinteDeBaseSecondaire
            self.couleurDeFace = config.teinteDeBaseTertiaire
        case .destructeurPrimaire:
            self.couleurDeFond = config.teinteAvertissement
            self.couleurDeFace = config.blancConstant
        case .destructeurSecondaire:
            self.couleurDeFond = config.teinteAvertissementSecondaire
            self.couleurDeFace = config.teinteAvertissementTertiaire
        case .custom:
            print()
        }
    }
}





public enum TypeBouton {
    case primaire, secondaire, destructeurPrimaire, destructeurSecondaire, custom
}





#Preview {
    Bouton(label: "Bouton Primaire") {
        print()
    }
    .environmentObject(ConfigurationAisen())
}
