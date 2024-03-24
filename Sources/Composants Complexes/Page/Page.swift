//
//  Page.swift
//
//
//  Created by Thomas Le Bonnec on 19/12/2023.
//

import SwiftUI


public struct Page<Contenu: View>: View {
    
    /* ----- Attributs ----- */
    
    public var titre: String
    public var contenu: Contenu    //TODO: Remédier au problème des AnyView
    
    @State var défilement = false
    
    
    
    /* ----- Inits ----- */
    
    public init(titre: String, @ViewBuilder contenu: () -> Contenu) {
        self.titre = titre
        self.contenu = contenu()
    }
    
    
    
    /* ----- Vue ----- */
    
    public var body: some View {
        GeometryReader { géometrie in
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 36) {
                        Text(titre.localized())
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        
                        
                        Text(défilement ? "Oui" : "Non")
                        
                        VStack(alignment: .leading, spacing: 24) {
                            contenu
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    }
                    .padding(.top, 20 + CGFloat(géometrie.safeAreaInsets.top))
                    .padding(.bottom, 20)
                    .padding(.horizontal, 36)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .ignoresSafeArea()
                
                
                // TODO: Intégrer l'entête
                /*VStack {
                    EnteteDePage(titre: "Titre de Page")
                        .frame(height: 45)
                    
                    Spacer()
                }
                */
            }
        }
    }
}





#Preview {
    Page(titre: "Page") {
        Text("Hello")
        Text("Hello")
        Text("Hello")
        Text("Hello")
        Text("Hello")
        Text("Hello")
    }
    .environmentObject(ConfigurationAisen())
    .frame(width: 300, height: 200)
    .background(Color.fondPrimaire)
}
