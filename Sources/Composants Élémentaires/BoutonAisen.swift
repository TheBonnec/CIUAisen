//
//  BoutonAisen.swift
//
//
//  Created by Thomas Le Bonnec on 27/11/2023.
//

import SwiftUI


@available(macOS 13, iOS 16, *)
public struct BoutonAisen: View {
    
    public init() {}
    
    public var body: some View {
        Button(action: {
            print("")
        }, label: {
            Text("Button")
                .frame(width: 200, height: 30)
        })
        .padding()
    }
}





#Preview {
    BoutonAisen()
}
