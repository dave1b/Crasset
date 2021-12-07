//
//  CryptocurrenciesView.swift
//  Crasset
//
//  Created by daniele Muheim on 18.11.21.
//

import SwiftUI

struct CryptocurrenciesView: View {
    @State private var cryptos: [Crypto] = [Crypto]()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack{
                    ForEach(cryptos, id: \.id) { crypto in
                        CryptoCard(id: crypto.id!, name: crypto.name!, symbol: crypto.symbol!, image: crypto.image!, current_price: crypto.current_price!, price_change_percentage_24h: crypto.price_change_percentage_24h!, marketCap: crypto.market_cap!, marketCapRank: crypto.market_cap_rank!, ath: crypto.ath!)
                    }
                }
            }.navigationTitle("All Cryptocurrencies")
        }
        
        .task {
            await APICaller.getAllCryptos(currencyID: "usd"){ cryptos in
                self.cryptos = cryptos
            }
        }
        
    }
}

struct CryptocurrenciesView_Previews: PreviewProvider {
    static var previews: some View {
        CryptocurrenciesView()
    }
}
