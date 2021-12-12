//
//  tabView.swift
//  Crasset
//
//  Created by daniele Muheim on 18.11.21.
//

import SwiftUI

struct tabView: View {
    
    init() {

   UITabBar.appearance().backgroundColor = UIColor.white

   }
    
    var body: some View {
        TabView {
            AssetsView()
                .tabItem({
                    Label("Assets", systemImage: "creditcard")
                })
            
            CryptocurrenciesView()
                .tabItem({
                    Label("Cryptocurrencies", systemImage: "bitcoinsign.circle.fill")
                })
            
            CalculatorView()
                .tabItem({
                    Label("Calculator", systemImage: "square.grid.3x3.bottomright.filled")
                })
          
        }
    }
}

struct tabView_Previews: PreviewProvider {
    static var previews: some View {
        tabView()
    }
}
