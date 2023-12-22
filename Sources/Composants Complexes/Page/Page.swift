//
//  Page.swift
//
//
//  Created by Thomas Le Bonnec on 19/12/2023.
//

import SwiftUI

public struct Page<Contenu: View>: View {
    
    public var titre: String
    public var contenu: Contenu    //TODO: Remédier au problème des AnyView
    
    
    public init(titre: String, @ViewBuilder contenu: () -> Contenu) {
        self.titre = titre
        self.contenu = contenu()
    }
    
    
    public var body: some View {
        GeometryReader { géometrie in
            ScrollView {
                VStack(alignment: .leading, spacing: 36) {
                    Text(titre.localized())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    
                    
                    VStack(alignment: .leading, spacing: 24) {
                        contenu
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
                .padding(.top, 20 + CGFloat(géometrie.safeAreaInsets.top))
                .padding(.bottom, 20)
                .padding(.horizontal, 36)
            }
            .scrollIndicators(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .ignoresSafeArea()
        }
    }
}





#Preview {
    Page(titre: "Page") {
        Text("Hello")
        Text("Hello")
    }
    .frame(width: 300, height: 200)
}
