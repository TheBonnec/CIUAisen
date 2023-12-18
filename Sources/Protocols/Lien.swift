//
//  Lien.swift
//
//
//  Created by Thomas Le Bonnec on 02/12/2023.
//

import Foundation
import SwiftUI


public protocol Lien {
    associatedtype T: Selectionnable
    associatedtype U: View
    
    var lien: T { get }
    var destination: U { get }
    
    init(lien: T, destination: U)
}
