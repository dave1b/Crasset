//
//  CryptoDetailView.swift
//  Crasset
//
//  Created by daniele Muheim on 22.11.21.
//

import SwiftUI
import Foundation

struct CryptoDetailView: View {
    @State var crypto: [Crypto]?
    var cryptoId: String
    var cryptoSymbol: String
    var capitalised: String
    var cryptoImage: String
    var cryptoCurrentPrice: Float
    var cryptoPriceChange: Float
    var cryptoMarketCap: Float
    var cryptoMarketCapRank: Int
    var ath: Float
    
    
    init(cryptoId: String, cryptoSymbol: String, cryptoImage: String, cryptoCurrentPrice: Float, cryptoPriceChange: Float, cryptoMarketCap: Float, cryptoMarketCapRank: Int, ath: Float){
        capitalised = (cryptoId.first!).uppercased() + String(cryptoId.dropFirst())
        self.cryptoId = cryptoId
        self.cryptoSymbol = cryptoSymbol
        self.cryptoImage = cryptoImage
        self.cryptoCurrentPrice = cryptoCurrentPrice
        self.cryptoPriceChange = cryptoPriceChange
        self.cryptoMarketCap = cryptoMarketCap
        self.cryptoMarketCapRank = cryptoMarketCapRank
        self.ath = ath
        
    }
    
    
    
    var body: some View {
        NavigationView {
            ScrollView() {
                VStack(alignment: .leading, spacing: 5.0) {
                    AsyncImage(url: URL(string: cryptoImage)){ image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }.aspectRatio(contentMode: .fit)
                        .frame(width: 75, alignment: .leading)
                        .padding([.top, .bottom], 40)
                        .padding(.leading, -10.0)
                    
                   
                    Text("Price")
                    HStack {
                        Text(String(format: "%.2f", cryptoCurrentPrice)).font(.system(size: 20, design: .default))
                        VStack(){
                            Text(String(format: "%.2f", cryptoPriceChange) + "%" + " (24h)")
                                .font(.system(size: 16, design: .default))
                                .foregroundColor(cryptoPriceChange < 0 ? .red : .green)
                        }
                    }
                    Group{
                        
                        Spacer()
                            .frame(height: 30)
                        Text("Market Cap")
                        Text(String(format: "%.2f", cryptoMarketCap)).font(.system(size: 20, design: .default))
                        Spacer()
                            .frame(height: 30)
                        Text("Market Cap Rank")
                        Text(String(cryptoMarketCapRank)).font(.system(size: 20, design: .default))
                        Spacer()
                            .frame(height: 30)
                        Text("ATH")
                        Text(String(format: "%.2f", ath)).font(.system(size: 20, design: .default))
                        Spacer()
                            .frame(height: 50)
                    }
                    /*
                     not working
                    Group{
                        Text("Links")
                        Text(crypto?[0].homepage?[0] ?? "no link")
                    }*/
                }
                .font(.system(size: 24, weight: .bold, design: .default))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30.0)
                .background(Color("ColorSet"))
                .cornerRadius(20)
                .padding([.leading, .trailing], 10.0)
                //.padding([.top, .bottom], 0)
                
                
            }.navigationTitle("\(capitalised) (\(cryptoSymbol))")
                .navigationTitle("hello")
            
            
              .task {
                  APICaller().getSingleDetailsCrypto(cryptoID: cryptoId, currencyID: "usd"){ cryptos in
             self.crypto = cryptos
                 //print(crypto?[0].homepage?[0])
             }
             
             }
        }
    }
}

struct CryptoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoDetailView(cryptoId: "bitcoin", cryptoSymbol: "btc", cryptoImage: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579", cryptoCurrentPrice: 54597, cryptoPriceChange: -0.04094 , cryptoMarketCap: 935248999.00, cryptoMarketCapRank: 1, ath: 132334.32)
    }
}
