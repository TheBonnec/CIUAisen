//
//  ChampDeTexte.swift
//
//
//  Created by Thomas Le Bonnec on 29/11/2023.
//

import SwiftUI

@available(macOS 13, iOS 16, *)
public struct ChampDeTexte<V: CustomStringConvertible & LosslessStringConvertible>: View {
    
    /* ----- Attributs ----- */
    
    var label: String
    @Binding var valeur: V?
    var type: TypeEntrée
    
    
    
    /* ----- Inits ----- */
    
    public init(label: String, entréeTextuelle: Binding<V?>) where V == String {
        self.label = label
        self._valeur = entréeTextuelle
        self.type = .texte
    }
    
    public init(label: String, entréeNumérale: Binding<V?>) where V == Int {
        self.label = label
        self._valeur = entréeNumérale
        self.type = .nombre
    }
    
    
    
    /* ----- Vues ----- */
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color.texteSecondaire)
                .padding(.leading, 4)
            
            switch type {
            case .texte: entréeTextuelle
            case .nombre: entréeNumérale
            }
        }
        .frame(minWidth: 100)
    }
    
    public var entréeTextuelle: some View {
        TextField(label, text: Binding(
            get: { String(describing: self.valeur) },
            set: { self.valeur = V($0) ?? self.valeur }
        ))
        .champDeTexteAisenClassique()
        
    }
    
    public var entréeNumérale: some View {
        TextField(label, value: Binding(
            get: {
                Double(self.valeur?.description ?? "0") ?? 0
            },
            set: {
                self.valeur = V(String($0)) ?? self.valeur
            }), formatter: NumberFormatter())
        .champDeTexteAisenClassique()
    }
    
    
    
    /* ----- Enum ------ */
    
    enum TypeEntrée {
        case texte, nombre
    }
}






#Preview {
    ChampDeTexte(label: "Label", entréeNumérale: .constant(4))
}
