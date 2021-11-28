//
//  CryptoCard.swift
//  Crasset
//
//  Created by daniele Muheim on 22.11.21.
//

import SwiftUI

struct CryptoCard: View {
    var id: String
    var name: String
    var symbol: String
    var image: String
    var current_price: Float
    var price_change_percentage_24h: Float
    var marketCap: Float
    var marketCapRank: Int
    var ath: Float
    
    var body: some View {
        NavigationLink(destination: CryptoDetailView(cryptoId: id, cryptoSymbol: symbol,cryptoImage: image, cryptoCurrentPrice: current_price, cryptoPriceChange: price_change_percentage_24h, cryptoMarketCap: marketCap, cryptoMarketCapRank: marketCapRank, ath: ath)) {
            VStack() {
                HStack {
                    AsyncImage(url: URL(string: image)){ image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }.aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                        .padding([.top, .leading, .bottom], 15)
                    
                    Group {
                        HStack {
                            Text(name)
                                .font(.headline)

                            Text(symbol)
                            Spacer()
                            let currentPrice = String(format: "%.2f", current_price)
                            Text(currentPrice)
                        }
                    }
                    .font(.system(size: 11, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    HStack {

                        Text(String(format: "%.2f", price_change_percentage_24h) + "%")
                            .font(.system(size: 13, weight: .bold, design: .default))
                            .foregroundColor(price_change_percentage_24h < 0 ? .red : .green)
                    }.padding()
                    
                }
                
                .frame(height: 100.0)
                .background(Color("ColorSet"))
                .cornerRadius(20)
                .padding([.leading, .trailing], 10.0)
                .padding([.top, .bottom], 0)
            }
        }
    }
}
struct CryptoCard_Previews: PreviewProvider {
    static var previews: some View {
        CryptoCard(id: ("bitcoin"), name:("bitcoin"),symbol: ("btc") ,image: ("bitcoin"), current_price: 60000, price_change_percentage_24h: 7.5, marketCap: 2234234, marketCapRank: 1, ath: 12323.2)
            .padding()
    }
}
