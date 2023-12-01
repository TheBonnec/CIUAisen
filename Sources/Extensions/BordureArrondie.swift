//
//  BordureArrondie.swift
//
//
//  Created by Thomas Le Bonnec on 29/11/2023.
//

import Foundation
import SwiftUI


extension View {
    func border(width: CGFloat, color: Color, cornerRadius: CGFloat) -> some View {
        overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(color, lineWidth: width)
        )
    }
}
