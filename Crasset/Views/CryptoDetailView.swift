//
//  CryptoDetailView.swift
//  Crasset
//
//  Created by daniele Muheim on 22.11.21.
//

import SwiftUI

struct CryptoDetailView: View {
    @State var crypto: Crypto?
    var id: String
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    Text(crypto?.name! ?? "bitcoin")
                }
            }.navigationTitle(crypto?.name! ?? "bitcoin")
        }
        
        .task {
            await APICaller().getSingleDetailsCrypto(cryptoID: id, currencyID: "usd"){ cryptos in
                self.crypto = cryptos
            }
            
        }
    }
}

struct CryptoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoDetailView(id: "bitcoin")
    }
}
