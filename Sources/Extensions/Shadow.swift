//
//  Shadow.swift
//
//
//  Created by Thomas Le Bonnec on 19/12/2023.
//

import SwiftUI


extension View {
    func ombrePrimaire() -> some View {
        self
            .shadow(color: Color.ombrePrimaire, radius: 24, x: 0, y: 0)
    }
    
    func ombreSecondaire() -> some View {
        self
            .shadow(color: Color.ombreSecondaire, radius: 16, x: 0, y: 0)
    }
}
