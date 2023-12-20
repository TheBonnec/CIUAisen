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
    
    @State private var sélection: String
    
    @State private var test: String = "test"
    
    
    
    
    
    /* ----- Inits ----- */
    
    // TODO: Sauvegarder les destinations dans un TuppleView
    public init(largeur: CGFloat = 250, cléPageAccueil: String, liens: () -> [LienDeNavigateur]) {
        self.largeur = largeur
        self.typeAffichage = .liens
        self.liens = liens()
        self.groupes = []
        
        self._sélection = State(initialValue: cléPageAccueil)
    }
    
    
    public init(largeur: CGFloat = 250, cléPageAccueil: String, groupes: [LienDeNavigateurGroupe]) {
        self.largeur = largeur
        self.typeAffichage = .groupes
        self.liens = []
        self.groupes = groupes
        
        self._sélection = State(initialValue: cléPageAccueil)
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
                    switch typeAffichage {
                    case .liens: 
                        liens[pageÀAfficherLiens()].destination
                    case .groupes:
                        let index = pageÀAfficherGroupes()
                        groupes[index[0]].liensDeNavigateur[index[1]].destination
                    }
                }
            }
        }
        .background(Color.fondPrimaire.ignoresSafeArea())
    }
    
    
    var affichageLiens: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ListeDeLiens(liens: liens, sélection: $sélection)
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
                        Text(groupe.titre.localized())
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.texteSecondaire)
                            .padding(.bottom, 6)
                            .padding(.horizontal, 10)
                    
                        ListeDeLiens(liens: groupe.liensDeNavigateur, sélection: $sélection)
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
    
    
    
    
    
    /* ----- Méthodes ----- */
    
    func pageÀAfficherLiens() -> Int {
        for i in 0..<liens.count {
            if liens[i].clé == sélection {
                return i
            }
        }
        return 0
    }
    
    
    func pageÀAfficherGroupes() -> [Int] {
        for i in 0..<groupes.count {
            for j in 0..<groupes[i].liensDeNavigateur.count {
                if groupes[i].liensDeNavigateur[j].clé == sélection {
                    return [i, j]
                }
            }
        }
        return [0, 0]
    }
    
    
    
    
    
    /* ----- Enum ----- */
    
    public enum TypeAffichage {
        case liens, groupes
    }
    
    
    
    
    /* ----- Struct Internes ----- */
    
    struct ListeDeLiens: View {
        
        var liens: [LienDeNavigateur]
        @Binding var sélection: String
        
        var body: some View {
            ForEach(liens) { item in
                Text("\(item.clé)".localized())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Rectangle()
                        .foregroundStyle(sélection == item.clé ? Color.elementSecondaire : Color.clear)
                        .contentShape(Rectangle())
                    )
                    .cornerRadius(4)
                    .onTapGesture {
                        self.sélection = item.clé
                    }
            }
        }
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
    return Navigateur(cléPageAccueil: "Chapitre 1", groupes: [
        LienDeNavigateurGroupe(titre: "Chapitre 1", liensDeNavigateur: [euclide, euclideEtendu]),
        LienDeNavigateurGroupe(titre: "Chapitre 2", liensDeNavigateur: [modulo])
    ])
    .frame(width: 700, height: 400)
    .background(Color.fondPrimaire)
}
