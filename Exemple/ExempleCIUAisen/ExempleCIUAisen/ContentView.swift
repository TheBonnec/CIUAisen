//
//  ContentView.swift
//  ExempleCIUAisen
//
//  Created by Thomas Le Bonnec on 28/11/2023.
//

import SwiftUI
import CIUAisen


struct ContentView: View {
    
    var options = [OptionTest2(clé: "Option 1"), OptionTest2(clé: "Option 2"), OptionTest2(clé: "Option 3"), OptionTest2(clé: "Option 4"), OptionTest2(clé: "Option 5")]
    
    
    var body: some View {
        ContentView2 {
            Text("Bonjour")
            Text("Monde")
            Image(systemName: "chevron.left")
        }
    }
}



struct ContentView2<Content: View>: View {
    
    var content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    
    var body: some View {
        content
            .onAppear {
                print(type(of: content))
            }
    }
}


struct OptionTest2: OptionSelecteur {
    let id = UUID()
    let clé: String
}



#Preview {
    ContentView()
}

