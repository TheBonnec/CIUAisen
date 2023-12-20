//
//  Cellule.swift
//
//
//  Created by Thomas Le Bonnec on 20/12/2023.
//

import SwiftUI


public struct Cellule<Content: View>: View {
    
    public var alignement: Alignment
    private var alignementHorizontal: HorizontalAlignment
    public var largeur: CGFloat?
    public var largeurMax: CGFloat?
    public var contenu: Content
    
    
    public init(alignement: Alignment = .leading, largeur: CGFloat? = nil, largeurMax: CGFloat? = nil, @ViewBuilder contenu: () -> Content) {
        self.alignement = alignement
        self.largeur = largeur
        self.largeurMax = largeurMax
        self.contenu = contenu()
        
        if alignement == .leading { self.alignementHorizontal = .leading }
        else if alignement == .trailing { self.alignementHorizontal = .trailing }
        else { self.alignementHorizontal = .center }
    }
    
    
    
    public var body: some View {
        HStack(spacing: 0) {
            if largeurMax == nil && alignement == .trailing {
                Spacer()
            }
            
            VStack(alignment: alignementHorizontal, spacing: 16) {
                contenu
            }
            
            if largeurMax == nil && alignement == .leading {
                Spacer()
            }
        }
        .padding(16)
        .frame(width: largeur)
        .frame(maxWidth: largeurMax, alignment: alignement)
        .background(Color.fondTertiaire)
        .cornerRadius(8)
        .bordureArrondie(width: 1, color: Color.bordurePrimaire, cornerRadius: 8)
        .ombreSecondaire()
    }
}





#Preview {
    Cellule(alignement: .leading, largeur: 200) {
        Text("Bonjour")
        Text("Bonjour, Monde !")
    }
    .padding(20)
    .frame(width: 300, height: 150)
}
