//
//  EnteteDePage.swift
//
//
//  Created by Thomas Le Bonnec on 14/01/2024.
//

import SwiftUI

struct EnteteDePage: View {
    
    /* ----- Attributs ----- */
    
    @EnvironmentObject var config: ConfigurationAisen
    var titre: String
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        VStack {
            Spacer()
            Text(titre)
                .fontWeight(.semibold)
                .padding(.bottom, 11)
        }
        .frame(maxWidth: .infinity)
        .background(config.fondSecondaire)
        .overlay(
            BottomRoundedRectangle(cornerRadius: 8)
                .stroke(config.bordurePrimaire, lineWidth: 2)
        )
        .clipShape(
            .rect(
                topLeadingRadius: 0,
                bottomLeadingRadius: 8,
                bottomTrailingRadius: 8,
                topTrailingRadius: 0
            )
        )
        .ombrePrimaire()
    }
    
    
    
    /* ----- Struct Custom ----- */
    
    struct BottomRoundedRectangle: Shape {
        var cornerRadius: CGFloat

        func path(in rect: CGRect) -> Path {
            var path = Path()

            // Démarre au coin supérieur gauche
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            // Ligne vers le coin inférieur gauche
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - cornerRadius))

            // Arc inférieur gauche
            path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 180),
                        endAngle: Angle(degrees: 90),
                        clockwise: true)

            // Ligne vers le coin inférieur droit
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY))

            // Arc inférieur droit
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 90),
                        endAngle: Angle(degrees: 0),
                        clockwise: true)

            // Ligne vers le coin supérieur droit
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))

            return path
        }
    }
}





#Preview {
    EnteteDePage(titre: "Titre de page")
        .environmentObject(ConfigurationAisen())
        .frame(width: 400, height: 70)
}
