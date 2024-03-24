//
//  ChampDeTexte.swift
//
//
//  Created by Thomas Le Bonnec on 29/11/2023.
//

import SwiftUI


public struct ChampDeTexte<V: CustomStringConvertible & LosslessStringConvertible>: View {
    
    /* ----- Attributs ----- */
    
    var libellé: String
    @Binding var valeur: V?
    var type: TypeEntrée
    
    
    
    /* ----- Inits ----- */
    
    public init(libellé: String, entréeTextuelle: Binding<V?>) where V == String {
        self.libellé = libellé
        self._valeur = entréeTextuelle
        self.type = .texte
    }
    
    public init(libellé: String, entréeEntière: Binding<V?>) where V == Int {
        self.libellé = libellé
        self._valeur = entréeEntière
        self.type = .entier
    }
    
    public init(libellé: String, entréeEntièrePositiveLarge: Binding<V?>) where V == UInt64 {
        self.libellé = libellé
        self._valeur = entréeEntièrePositiveLarge
        self.type = .entierPositifLarge
    }
    
    public init(libellé: String, entréeDécimale: Binding<V?>) where V == Double {
        self.libellé = libellé
        self._valeur = entréeDécimale
        self.type = .décimal
    }
    
    
    
    /* ----- Vues ----- */
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(libellé.localized())
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color.texteSecondaire)
                .padding(.leading, 4)
            
            switch type {
            case .texte: entréeTextuelle
            case .entier: entréeNumérale
            case .entierPositifLarge: entréeEntierPositifLarge
            case .décimal: entréeDécimale
            }
        }
        .frame(minWidth: 100)
    }
    
    public var entréeTextuelle: some View {
        TextField(libellé, text: Binding(
            get: { String(describing: self.valeur ?? "" as! V) },
            set: { self.valeur = V($0) ?? self.valeur }
        ))
        .champDeTexteAisenClassique()
        
    }
    
    public var entréeNumérale: some View {
        /*
        TextField(label, value: Binding(
            get: {
                Double(self.valeur?.description ?? "0") ?? 0
            },
            set: {
                self.valeur = V(String($0)) ?? self.valeur
            }), formatter: NumberFormatter())
         */
        TextField(libellé, value: Binding(
            get: { valeur as! Int? ?? 0 },
            set: { valeur = $0 as? V }
        ), format: .number)
        .champDeTexteAisenClassique()
    }
    
    public var entréeEntierPositifLarge: some View {
        TextField(libellé, value: Binding(
            get: { valeur as! UInt64? ?? 0 },
            set: { valeur = $0 as? V }
        ), format: .number)
        .champDeTexteAisenClassique()
    }
    
    public var entréeDécimale: some View {
        TextField(libellé, value: Binding(
            get: { valeur as! Double? ?? 0 },
            set: { valeur = $0 as? V }
        ), format: .number)
        .champDeTexteAisenClassique()
    }
    
    
    
    /* ----- Enum ------ */
    
    enum TypeEntrée {
        case texte, entier, entierPositifLarge, décimal
    }
}






#Preview {
    ChampDeTexte(libellé: "Libellé", entréeEntière: .constant(4))
}
