//
//  CryptocurrenciesView.swift
//  Crasset
//
//  Created by daniele Muheim on 18.11.21.
//

import SwiftUI

struct CryptocurrenciesView: View {
    @State private var avatarImage = UIImage(named: "Bitcoin")!
    @State private var cryptoArray: [Crypto] = [Crypto]()
    @State private var zahl = 5
    
    
    var body: some View {
        NavigationView {
            HStack(alignment: .center) {
                Image(uiImage: avatarImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                    .padding([.top, .leading, .bottom], 15)
                
                VStack(alignment: .leading) {
                    Group {
                        HStack {
                            Text("\(zahl)")

                            //Text("\(cryptoArray[0].id ?? "did not work")")
                            Text("Bitcoin (BTC)")
                            Spacer()
                            Text("$60.383,7")
                        }
                    }
                    .font(.system(size: 13, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .padding(.all, 15)
                    
                    HStack {
                        Spacer()
                        Text("-8,36%")                    .font(.system(size: 13, weight: .bold, design: .default))
                            .foregroundColor(.red)
                    }.padding()
                    
                }
                Spacer()
            }        .frame(height: 100.0)

            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color("ColorSet"))
            .cornerRadius(20)
            .padding(.all, 10)
            .navigationBarTitle(Text("All Cryptocurrencies").font(.subheadline))
            
   
        }
        .task{
            zahl = 10
            print("hello world")
        }
        .task{
            APICaller.getAllCryptos(currencyID: "usd"){ cryptos in
                cryptoArray = cryptos
            print("hello world")
            }
        }
        
    }
}

struct CryptocurrenciesView_Previews: PreviewProvider {
    static var previews: some View {
        CryptocurrenciesView()
    }
}
