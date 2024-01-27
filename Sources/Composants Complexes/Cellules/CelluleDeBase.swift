//
//  CelluleDeBase.swift
//
//
//  Created by Thomas Le Bonnec on 20/12/2023.
//

import SwiftUI


@available(macOS 13, iOS 16, *)
public struct CelluleDeBase<Content: View>: View {
    
    /* ----- Attributs ----- */
    
    @EnvironmentObject var config: ConfigurationAisen
    
    var alignement: Alignment
    var alignementHorizontal: HorizontalAlignment
    var largeur: CGFloat?
    var largeurMax: CGFloat?
    var contenu: Content
    
    
    
    /* ----- Inits ----- */
    
    public init(alignement: Alignment = .leading, largeur: CGFloat? = nil, largeurMax: CGFloat? = nil, @ViewBuilder contenu: () -> Content) {
        self.alignement = alignement
        self.largeur = largeur
        self.largeurMax = largeurMax
        self.contenu = contenu()
        
        if alignement == .leading { self.alignementHorizontal = .leading }
        else if alignement == .trailing { self.alignementHorizontal = .trailing }
        else { self.alignementHorizontal = .center }
    }
    
    
    
    /* ----- Vue ----- */
    
    public var body: some View {
        Cellule(alignement: alignement, largeur: largeur, largeurMax: largeurMax, couleurDeFond: config.teinteDeBaseSecondaire) {
            contenu
        }
    }
}





#Preview {
    CelluleDeBase(alignement: .leading, largeurMax: .infinity) {
        Text("Bonjour")
    }
    .environmentObject(ConfigurationAisen())
    .padding(20)
    .frame(width: 300, height: 150)
}
