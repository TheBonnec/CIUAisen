//
//  Cellule.swift
//
//
//  Created by Thomas Le Bonnec on 20/12/2023.
//

import SwiftUI


public struct Cellule<Content: View>: View {
    
    public var alignement: Alignment
    public var largeur: CGFloat?
    public var largeurMax: CGFloat?
    public var contenu: Content
    
    
    public init(alignement: Alignment = .leading, largeur: CGFloat? = nil, largeurMax: CGFloat? = nil, @ViewBuilder contenu: () -> Content) {
        self.alignement = alignement
        self.largeur = largeur
        self.largeurMax = largeurMax
        self.contenu = contenu()
    }
    
    
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 0) {
                if largeurMax == nil && alignement == .trailing {
                    Spacer()
                }
                
                contenu
                
                if largeurMax == nil && alignement == .leading {
                    Spacer()
                }
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
    Cellule(alignement: .trailing, largeur: 200) {
        Text("Bonjour")
    }
    .padding(20)
    .frame(width: 300, height: 150)
}
