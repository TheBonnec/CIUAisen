//
//  Selecteur.swift
//
//
//  Created by Thomas Le Bonnec on 29/11/2023.
//

import SwiftUI

@available(macOS 13, iOS 16, *)
struct Selecteur<T: OptionSelecteur>: View {
    
    /* ----- Attributs ----- */
    
    private let options: [T]
    @State var optionSélectionné: T
    
    private let hauteur: CGFloat = 28
    @State private var largeur: CGFloat = 0
    
    
    
    /* ----- Inits ----- */

    init(options: [T]) {
        self.options = options
        self._optionSélectionné = State(initialValue: options[0])
    }

    
    
    /* ----- Vues ----- */
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                vueSélecteur
                vueOptions
            }
            .onAppear {
                largeur = geo.size.width / CGFloat(options.count)
            }
        }
        .frame(height: hauteur)
        .padding(3)
        .background(Color.elementPrimaire)
        .cornerRadius(4)
        .border(width: 1, color: .elementSecondaire, cornerRadius: 4)
        .padding()
        .background(Color.fondSecondaire)
    }
    
    
    var vueSélecteur: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(Color.clear)
                .frame(width: CGFloat(obtenirIndex(optionSélectionné)) * largeur, height: 24)
            
            Rectangle()
                .fill(Color.elementSecondaire)
                .frame(width: largeur, height: hauteur)
                .cornerRadius(2)
                .animation(.easeOut(duration: 0.18), value: optionSélectionné)
                //.animation(.bouncy(duration: 0.18, extraBounce: 0.02), value: optionSélectionné)
        }
    }
    
    
    var vueOptions: some View {
        HStack(spacing: 0) {
            ForEach(options, id: \.id) { option in
                Button(action: {
                    withAnimation {
                        self.optionSélectionné = option
                    }
                }, label: {
                    Text(option.clé)
                        .foregroundStyle(optionSélectionné.id == option.id ? Color.textePrimaire : Color.texteSecondaire)
                        .frame(width: largeur, height: hauteur)
                })
                .buttonStyle(PlainButtonStyle())
                
                //.frame(width: largeur, height: hauteur)
            }
        }
    }
    
    
    
    /* ----- Méthodes ------ */
    
    func obtenirIndex(_ opt: T) -> Int {
        return options.firstIndex { option in
            option.id == opt.id
        } ?? 0
    }
}




struct OptionTest: OptionSelecteur {
    let id = UUID()
    let clé: String
}

#Preview {
    Selecteur(options: [OptionTest(clé: "Option 1"), OptionTest(clé: "Option 2"), OptionTest(clé: "Option 3"), OptionTest(clé: "Option 4")])
}
