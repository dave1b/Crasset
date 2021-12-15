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

            }
            .background(Color(#colorLiteral(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)))
            .navigationTitle("All Cryptocurrencies")
        }
        
        .task {
            do {
                self.cryptos = try await APICaller.getAllCryptos(currencyID: "usd")
            }  catch {
                print("Request failed with error: \(error)")
            }
        }
        
    }
}

struct CryptocurrenciesView_Previews: PreviewProvider {
    static var previews: some View {
        CryptocurrenciesView()
    }
}
