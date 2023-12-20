//
//  Cellule.swift
//
//
//  Created by Thomas Le Bonnec on 20/12/2023.
//

import SwiftUI


public struct Cellule<Content: View>: View {
    
    public var alignement: Alignment
    public var contenu: Content
    
    
    public init(alignement: Alignment = .leading, @ViewBuilder contenu: () -> Content) {
        self.alignement = alignement
        self.contenu = contenu()
    }
    
    
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            contenu
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: alignement)
        .background(Color.fondTertiaire)
        .cornerRadius(8)
        .bordureArrondie(width: 1, color: Color.bordurePrimaire, cornerRadius: 8)
        .ombreSecondaire()
    }
}





#Preview {
    Cellule {
        Text("Bonjour")
    }
    .padding(20)
    .frame(width: 300, height: 150)
}
