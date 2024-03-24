//
//  Navigateur.swift
//
//
//  Created by Thomas Le Bonnec on 02/12/2023.
//

import SwiftUI


public struct Navigateur: View {
    
    /* ----- Attributs ----- */
    
    var largeur: CGFloat
    var typeAffichage: TypeAffichage
    var liens: [LienDeNavigateur]
    var groupes: [LienDeNavigateurGroupe]
    
    @State private var sélection: UUID
    
    
    
    
    
    /* ----- Inits ----- */
    
    // TODO: Sauvegarder les destinations dans un TuppleView
    public init(largeur: CGFloat = 250, pageAccueil: LienDeNavigateur, liens: () -> [LienDeNavigateur]) {
        self.largeur = largeur
        self.typeAffichage = .liens
        self.liens = liens()
        self.groupes = []
        
        self._sélection = State(initialValue: pageAccueil.id)
    }
    
    
    public init(largeur: CGFloat = 250, pageAccueil: LienDeNavigateur, groupes: [LienDeNavigateurGroupe]) {
        self.largeur = largeur
        self.typeAffichage = .groupes
        self.liens = []
        self.groupes = groupes
        
        self._sélection = State(initialValue: pageAccueil.id)
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
                    pageÀAfficher()
                }
            }
        }
        .background(Color.fondPrimaire.ignoresSafeArea())
    }
    
    
    var affichageLiens: some View {
        ScrollView(showsIndicators: false) {
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
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 32) {
                ForEach(groupes) { groupe in
                    VStack(alignment: .leading, spacing: 0) {
                        Text(groupe.titre.localized())
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.texteSecondaire)
                            .padding(.bottom, 8)
                            .padding(.horizontal, 12)
                    
                        ListeDeLiens(liens: groupe.liensDeNavigateur, sélection: $sélection)
                    }
                }
            }
            .padding(10)
            .padding(.top, 8)
        }
        .frame(width: largeur)
        .bordureArrondie(width: 2, color: .bordurePrimaire, cornerRadius: 8)
        .background(Color.fondSecondaire)
        .cornerRadius(8)
        .ombrePrimaire()
        .padding([.vertical, .leading], 20)
    }
    
    
    
    
    
    /* ----- Méthodes ----- */
    
    func pageÀAfficher() -> AnyView {
        switch typeAffichage {
        case .liens:
            for lien in liens {
                if lien.id == sélection {
                    return lien.destination
                }
            }
        case .groupes:
            for groupe in groupes {
                for lien in groupe.liensDeNavigateur {
                    if lien.id == sélection {
                        return lien.destination
                    }
                }
            }
        }
        
        let pageParDefault = Page(titre: "") {
            Text("Rien. Nada. Ничего нет.")
        }
        
        return AnyView(pageParDefault)
    }
    
    
    
    
    
    /* ----- Enum ----- */
    
    public enum TypeAffichage {
        case liens, groupes
    }
    
    
    
    
    /* ----- Struct Internes ----- */
    
    struct ListeDeLiens: View {
        
        var liens: [LienDeNavigateur]
        @Binding var sélection: UUID
        
        var body: some View {
            ForEach(liens) { item in
                Text("\(item.clé)".localized())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(Rectangle()
                        .foregroundStyle(sélection == item.id ? Color.elementSecondaire : Color.clear)
                        .contentShape(Rectangle())
                    )
                    .cornerRadius(4)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged({ _ in
                                self.sélection = item.id
                            })
                    )
            }
        }
    }
}






#Preview {
    let euclide = LienDeNavigateur(clé: "Algorithme d'Euclide - PGCD", destination:
        Page(titre: "Algorithme d'Euclide - PGCD", contenu: {
            Cellule {
                ChampDeTexte(libellé: "a", entréeEntière: .constant(4))
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
    
    
    return Navigateur(pageAccueil: euclide, groupes: [
        LienDeNavigateurGroupe(titre: "Chapitre 1", liensDeNavigateur: [euclide, euclideEtendu]),
        LienDeNavigateurGroupe(titre: "Chapitre 2", liensDeNavigateur: [modulo])
    ])
    .frame(width: 700, height: 400)
    .background(Color.fondPrimaire)
}
