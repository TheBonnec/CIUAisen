//
//  LienDeNavigateurGroupe.swift
//
//
//  Created by Thomas Le Bonnec on 18/12/2023.
//

import SwiftUI


@available(macOS 13, iOS 16, *)
public struct LienDeNavigateurGroupe: Identifiable {
    public let id = UUID()
    public let titre: String
    public let liensDeNavigateur: [LienDeNavigateur]
    
    
    public init(titre: String, liensDeNavigateur: [LienDeNavigateur]) {
        self.titre = titre
        self.liensDeNavigateur = liensDeNavigateur
    }
}
