//
//  Navigateur.swift
//
//
//  Created by Thomas Le Bonnec on 02/12/2023.
//

import SwiftUI


public struct Navigateur: View {
    
    /* ----- Attributs ----- */
    
    public var largeur: CGFloat
    public var typeAffichage: TypeAffichage
    public var liens: [LienDeNavigateur]
    public var groupes: [LienDeNavigateurGroupe]
    
    @State private var sélection: LienDeNavigateur
    
    
    
    
    
    /* ----- Inits ----- */
    
    // TODO: Sauvegarder les destinations dans un TuppleView
    public init(largeur: CGFloat = 250, liens: () -> [LienDeNavigateur]) {
        self.largeur = largeur
        self.typeAffichage = .liens
        self.liens = liens()
        self.groupes = []
        
        let pageParDefault = LienDeNavigateur(clé: "nul", destination: Page(titre: "", contenu: {
            Text("Rien. Nada. Ничего нет.")
        }))
        
        if !liens().isEmpty {
            self._sélection = State(initialValue: liens().first!)
        } else {
            self._sélection = State(initialValue: pageParDefault)
        }
    }
    
    
    public init(largeur: CGFloat = 250, groupes: () -> [LienDeNavigateurGroupe]) {
        self.largeur = largeur
        self.typeAffichage = .groupes
        self.liens = []
        self.groupes = groupes()
        
        let pageParDefault = LienDeNavigateur(clé: "nul", destination: Page(titre: "", contenu: {
            Text("Rien. Nada. Ничего нет.")
        }))
        
        if !groupes().isEmpty {
            let premierGroupe = groupes().first!
            if !premierGroupe.liensDeNavigateur.isEmpty {
                self._sélection = State(initialValue: premierGroupe.liensDeNavigateur.first!)
            } else {
                self._sélection = State(initialValue: pageParDefault)
            }
        } else {
            self._sélection = State(initialValue: pageParDefault)
        }
    }
    
    
    
    
    
    /* ----- Vues ----- */
    
    public var body: some View {
        HStack(spacing: 0) {
            // Barre Latérale
            switch typeAffichage {
            case .liens: affichageLiens
            case .groupes: affichageGroupes
            }
            
            
            // Page
            VStack {
                HStack(alignment: .top) {
                    sélection.destination
                }
            }
        }
    }
    
    
    var affichageLiens: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(liens) { item in
                    Text("\(item.clé)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Rectangle()
                            .foregroundStyle(sélection.clé == item.clé ? Color.elementSecondaire : Color.clear)
                            .contentShape(Rectangle())
                        )
                        .cornerRadius(4)
                        .onTapGesture {
                            self.sélection = item
                        }
                }
            }
            .padding(10)
        }
        .frame(width: largeur)
        .bordureArrondie(width: 1, color: .bordurePrimaire, cornerRadius: 8)
        .background(Color.fondSecondaire)
        .cornerRadius(8)
        .ombrePrimaire()
        .padding([.vertical, .leading], 20)
    }
    
    
    var affichageGroupes: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(groupes) { groupe in
                    VStack(alignment: .leading, spacing: 0) {
                        Text(groupe.titre)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.texteSecondaire)
                            .padding(.bottom, 6)
                            .padding(.horizontal, 10)
                    
                        ForEach(groupe.liensDeNavigateur) { item in
                            Text("\(item.clé)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Rectangle()
                                    .foregroundStyle(sélection.clé == item.clé ? Color.elementSecondaire : Color.clear)
                                    .contentShape(Rectangle())
                                )
                                .cornerRadius(4)
                                .onTapGesture {
                                    self.sélection = item
                                }
                        }
                    }
                }
            }
            .padding(10)
            .padding(.top, 6)
        }
        .frame(width: largeur)
        .bordureArrondie(width: 2, color: .bordurePrimaire, cornerRadius: 8)
        .background(Color.fondSecondaire)
        .cornerRadius(8)
        .ombrePrimaire()
        .padding([.vertical, .leading], 20)
    }
    
    
    
    
    
    /* ----- Enum ----- */
    
    public enum TypeAffichage {
        case liens, groupes
    }
}






#Preview {
    let euclide = LienDeNavigateur(clé: "Algorithme d'Euclide - PGCD", destination:
        Page(titre: "Algorithme d'Euclide - PGCD", contenu: {
            Cellule {
                ChampDeTexte(label: "a", entréeNumérale: .constant(4))
            }
        }))
    let euclideEtendu = LienDeNavigateur(clé: "Algorithme Étendu d'Euclide", destination:
        Page(titre: "Algorithme Étendu d'Euclide", contenu: {
            Text("Bonjour")
        }))
    let modulo = LienDeNavigateur(clé: "Modulo", destination: 
        Page(titre: "Modulo", contenu: {
            Text("Bonjour")
        }))
    
    /*return Navigateur {[
        euclide, euclideEtendu, modulo
    ]}*/
    return Navigateur {[
        LienDeNavigateurGroupe(titre: "Chapitre 1", liensDeNavigateur: [euclide, euclideEtendu]),
        LienDeNavigateurGroupe(titre: "Chapitre 2", liensDeNavigateur: [modulo])
    ]}
    .frame(width: 700, height: 400)
    .background(Color.fondPrimaire)
}
