//
//  Navigateur.swift
//
//
//  Created by Thomas Le Bonnec on 02/12/2023.
//

import SwiftUI


struct Navigateur: View {
    
    var contenu: [LienDeNavigateur]
    @State private var sélection: LienDeNavigateur
    
    // TODO: Sauvegarder les destinations dans un TuppleView
    init(contenu: () -> [LienDeNavigateur]) {
        self.contenu = contenu()
        self._sélection = State(initialValue: contenu().first!)
    }
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                ScrollView {
                    ForEach(contenu) { item in
                        Text("\(item.clé)")
                            .onTapGesture {
                                self.sélection = item
                            }
                    }
                    .padding(10)
                }
                .background(Color.red)
            }
            .frame(width: 250)
            .border(width: 3, color: .bordurePrimaire, cornerRadius: 8)
            .background(Color.fondSecondaire)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.12), radius: 24)
            
            
            VStack {
                AnyView(sélection.lienDeNavigateur.destination)
            }
        }
    }
}






#Preview {
    return Navigateur {
        [
            LienDeNavigateur(clé: "Algorithme d'Euclide - PGCD", destination: Text("Hello")),
            LienDeNavigateur(clé: "Algorithme d'Euclide", destination: Image(systemName: "chevron.left"))
        ]
    }
    .frame(width: 500)
    .padding(20)
    .background(Color.fondPrimaire)
}
