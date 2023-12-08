//
//  OptionSelecteur.swift
//
//
//  Created by Thomas Le Bonnec on 30/11/2023.
//

import Foundation


public protocol Selectionnable: Identifiable, Equatable, Hashable {
    var id: UUID { get }
    var clé: String { get }
    
    init()
}
