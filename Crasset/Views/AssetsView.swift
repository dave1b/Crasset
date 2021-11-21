//
//  AssetsView.swift
//  Crasset
//
//  Created by daniele Muheim on 18.11.21.
//

import SwiftUI

struct AssetsView: View {
    var body: some View {
        VStack {
            NavigationView {
                AssetsChart() .navigationTitle("Assets")
            }
            
        }
    }
}

struct AssetsView_Previews: PreviewProvider {
    static var previews: some View {
        AssetsView()
    }
}
