//
//  Navigateur.swift
//
//
//  Created by Thomas Le Bonnec on 02/12/2023.
//

import SwiftUI


struct Navigateur: View {
    
    var contenu: any ProtocolLienDeNavigateur
    
    
    init(@ViewBuilder contenu: @escaping () -> any ProtocolLienDeNavigateur) {
        self.contenu = contenu()
    }
    
    
    var body: some View {
        VStack {
            ScrollView {
                contenu
                    .modifier(StyleDeLienDeNavigateur())
            }
        }
        .border(width: 3, color: .bordurePrimaire, cornerRadius: 8)
        .background(Color.fondSecondaire)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.12), radius: 24)
    }
}




struct StyleDeLienDeNavigateur: ViewModifier {
    func body(content: Content) -> some View {
        if let _ = content as? ProtocolLienDeNavigateur {
            return AnyView(content
                .offset(x: -10)
            )
        } else {
            return AnyView(content)
        }
    }
}





#Preview {
    let lien = OptionTest(clé: "Algorithme d'Euclide - PGCD")
    @State var selection = OptionTest(clé: "")
    
    return Navigateur {
        LienDeNavigateur(lien: lien, destination: Text(""), selection: $selection)
    }
    .frame(width: 300)
    .padding(20)
    .background(Color.fondPrimaire)
}
