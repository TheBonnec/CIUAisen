//
//  File.swift
//  
//
//  Created by Thomas Le Bonnec on 29/11/2023.
//

import Foundation
import SwiftUI


extension TextField {
    public func champDeTexteAisenClassique() -> some View {
        self
            .textFieldStyle(PlainTextFieldStyle())
            .padding(.vertical, 7)
            .padding(.horizontal, 10)
            .background(Color.elementPrimaire)
            .cornerRadius(4)
            .border(width: 1, color: .bordurePrimaire, cornerRadius: 4)
    }
}
