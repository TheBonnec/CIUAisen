//
//  ConfigurationAisen.swift
//
//
//  Created by Thomas Le Bonnec on 12/01/2024.
//

import Foundation
import SwiftUI
import Combine


public class ConfigurationAisen: ObservableObject {
    // ----- COULEURS ----- //
    
    // Bordures
    @Published public var bordurePrimaire = Color.bordurePrimaire
    @Published public var bordureGenerale = Color.bordureGenerale
    
    // Éléments
    @Published public var elementPrimaire = Color.elementPrimaire
    @Published public var elementSecondaire = Color.elementSecondaire
    
    // Fonds
    @Published public var fondPrimaire = Color.fondPrimaire
    @Published public var fondSecondaire = Color.fondSecondaire
    @Published public var fondTertiaire = Color.fondTertiaire
    
    // Ombres
    @Published public var ombrePrimaire = Color.ombrePrimaire
    @Published public var ombreSecondaire = Color.ombreSecondaire
    
    // Teintes
    @Published public var blancConstant = Color.blancConstant
    @Published public var teinteDeBase = Color.teinteDeBase
    @Published public var teinteDeBaseSecondaire = Color.teinteDeBaseSecondaire
    @Published public var teinteDeBaseTertiaire = Color.teinteDeBaseTertiaire
    @Published public var teinteAvertissement = Color.teinteAvertissement
    @Published public var teinteAvertissementSecondaire = Color.teinteAvertissementSecondaire
    @Published public var teinteAvertissementTertiaire = Color.teinteAvertissementTertiaire
    
    // Textes
    @Published public var textePrimaire = Color.textePrimaire
    @Published public var texteSecondaire = Color.texteSecondaire
    @Published public var texteTertiaire = Color.texteTertiaire
}
