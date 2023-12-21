//
//  Selecteur.swift
//
//
//  Created by Thomas Le Bonnec on 29/11/2023.
//

import SwiftUI

@available(macOS 13, iOS 16, *)
public struct Selecteur<T: Selectionnable>: View {
    
    /* ----- Attributs ----- */
    
    private let options: [T]
    @Binding var optionSélectionné: T
    
    private let hauteur: CGFloat = 32
    @State private var largeur: CGFloat = 0
    
    
    
    /* ----- Inits ----- */

    public init(options: [T], selection: Binding<T>) {
        self.options = options
        self._optionSélectionné = selection
    }

    
    
    /* ----- Vues ----- */
    
    public var body: some View {
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
        .bordureArrondie(width: 1, color: .bordurePrimaire, cornerRadius: 4)
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
                    Text(option.clé.localized())
                        .foregroundStyle(optionSélectionné.id == option.id ? Color.textePrimaire : Color.texteSecondaire)
                        .frame(width: largeur, height: hauteur)
                        .contentShape(Rectangle())
                })
                .buttonStyle(PlainButtonStyle())
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





#Preview {
    let options = [LienGenerique(clé: "Option 1"), LienGenerique(clé: "Option 2"), LienGenerique(clé: "Option 3"), LienGenerique(clé: "Option 4")]
    @State var selection = options[0]
    
    return Selecteur(options: options, selection: $selection)
}
