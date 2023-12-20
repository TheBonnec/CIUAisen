//
//  Page.swift
//
//
//  Created by Thomas Le Bonnec on 19/12/2023.
//

import SwiftUI

public struct Page: View {
    
    public var titre: String
    public var contenu: AnyView    //TODO: Remédier au problème des AnyView
    
    
    public init<Content: View>(titre: String, @ViewBuilder contenu: () -> Content) {
        self.titre = titre
        self.contenu = AnyView(contenu())
    }
    
    
    public var body: some View {
        GeometryReader { géometrie in
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text(titre)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    
                    
                    VStack(alignment: .leading, spacing: 16) {
                        contenu
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
                .padding(.top, 20 + CGFloat(géometrie.safeAreaInsets.top))
                .padding(.horizontal, 36)
            }
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
