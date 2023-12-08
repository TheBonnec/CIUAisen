//
//  LienDeNavigateur.swift
//
//
//  Created by Thomas Le Bonnec on 01/12/2023.
//

import SwiftUI

public struct LienDeNavigateur<T: Selectionnable, Destination: View>: View, ProtocolLienDeNavigateur {
    
    /* ----- Attributs ----- */
    
    let lien: T
    let destination: Destination
    @Binding var sélection: T
    
    
    
    /* ----- Inits ----- */
    
    public init(lien: T, destination: Destination, selection: Binding<T>) {
        self.lien = lien
        self.destination = destination
        self._sélection = selection
    }
    
    
    
    /* ----- Vues ----- */
    
    public var body: some View {
        HStack(spacing: 8) {
            Text(lien.clé)
            Spacer()
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 10)
        .background(Rectangle()
            .foregroundStyle(lien.id == sélection.id ? Color.elementSecondaire : Color.clear))
        .cornerRadius(4)
        .onTapGesture {
            if sélection.id != lien.id {
                sélection = lien
            }
        }
    }
}





#Preview {
    let lien = OptionTest(clé: "Algorithme d'Euclide - PGCD")
    @State var selection = lien
    
    return LienDeNavigateur(lien: lien, destination: Text(""), selection: $selection)
        .padding()
        .background(Color.fondSecondaire)
}
