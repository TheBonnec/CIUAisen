//
//  Cellule.swift
//
//
//  Created by Thomas Le Bonnec on 20/12/2023.
//

import SwiftUI


@available(macOS 13, iOS 16, *)
public struct Cellule<Content: View>: View {
    
    /* ----- Attributs ----- */
    
    @EnvironmentObject var config: ConfigurationAisen
    
    var alignement: Alignment
    var alignementHorizontal: HorizontalAlignment
    var largeur: CGFloat?
    var largeurMax: CGFloat?
    @State var couleurBordure: Color
    @State var couleurDeFond: Color
    var contenu: Content
    
    
    
    /* ----- Inits ----- */
    
    public init(alignement: Alignment = .leading, largeur: CGFloat? = nil, largeurMax: CGFloat? = nil, couleurDeFond: Color? = nil, @ViewBuilder contenu: () -> Content) {
        self.alignement = alignement
        self.largeur = largeur
        self.largeurMax = largeurMax
        // Si aucune couleurDeFond n'est spécifiée, utiliser la bordure associé, sinon utiliser une bordure générique
        self._couleurBordure = State(initialValue: Color.clear)
        self._couleurDeFond = State(initialValue: (couleurDeFond == nil) ? Color.clear : couleurDeFond!)
        self.contenu = contenu()
        
        // alignement et alignementHorizontal ne peuvent pas être fusionnés car ils sont tous deux utilisés
        if alignement == .leading { self.alignementHorizontal = .leading }
        else if alignement == .trailing { self.alignementHorizontal = .trailing }
        else { self.alignementHorizontal = .center }
    }
    
    
    
    /* ----- Vues ----- */
    
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
        .background(couleurDeFond)
        .cornerRadius(8)
        .bordureArrondie(width: 1, color: couleurBordure, cornerRadius: 8)
        .ombreSecondaire()
        .onAppear {
            définirCouleurs()
        }
    }
    
    
    
    /* ----- Fonctions ----- */
    
    func définirCouleurs() {
        // Si aucune couleurDeFond n'est spécifiée, utiliser la bordure associé, sinon utiliser une bordure générique
        self.couleurBordure = (couleurDeFond == Color.clear) ? config.bordurePrimaire : config.bordureGenerale
        self.couleurDeFond = (couleurDeFond == Color.clear) ? config.fondTertiaire : couleurDeFond
    }
}





#Preview {
    Cellule(largeur: 200) {
        Text("Bonjour")
        Text("Bonjour, Monde !")
    }
    .environmentObject(ConfigurationAisen())
    .padding(20)
    .frame(width: 300, height: 150)
}
