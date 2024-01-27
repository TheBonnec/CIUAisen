//
//  SelecteurDeroulant.swift
//
//
//  Created by Thomas Le Bonnec on 30/11/2023.
//

import SwiftUI


@available(macOS 13, iOS 16, *)
public struct SelecteurDeroulant<T: Selectionnable>: View {
    
    /* ----- Attributs ----- */
    
    private let options: [T]
    @Binding var selection: T
    
    
    
    /* ----- Inits ----- */
    
    public init(options: [T], selection: Binding<T>) {
        self.options = options
        self._selection = selection
    }
    
    
    
    /* ----- Vues ----- */
    
    public var body: some View {
        VStack {
            Menu(content: {
                contenuSelecteur
            }, label: {
                labelSelecteur
            })
            .buttonStyle(.plain)
        }
    }
    
    
    var labelSelecteur: some View {
        HStack(spacing: 0) {
            Text(selection.clé.localized())
            Spacer()
            Image(systemName: "chevron.down")
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
        .background(Color.elementSecondaire)
        .cornerRadius(4)
    }
    
    
    var contenuSelecteur: some View {
        ForEach(options, id: \.id) { option in
            Button(action: {
                self.selection = option
            }, label: {
                Text(option.clé.localized())
            })
            .buttonStyle(.plain)
        }
    }
}





#Preview {
    let options = [ElementSelectionnable(clé: "Option 1"), ElementSelectionnable(clé: "Option 2"), ElementSelectionnable(clé: "Option 3"), ElementSelectionnable(clé: "Option 4")]
    @State var selection = options[0]
    
    return SelecteurDeroulant(options: options, selection: $selection)
        .frame(width: 300, height: 500)
        .padding()
        .background(Color.fondSecondaire)
}
