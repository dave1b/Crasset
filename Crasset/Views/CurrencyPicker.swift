//
//  CurrencyPicker.swift
//  Crasset
//
//  Created by Dave Brunner on 28.11.21.
//

import Foundation
import SwiftUI

struct CurrencyPicker: View{
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    @Binding var pickedCurrency: String
    var currencies = ["USD","CHF","EURI","bitcoin", "ethereum", "binancecoin","solana","cardano","ripple","polkadot","dogecoin","shiba-inu","chainlink","matic-network","matic-network","uniswap","stellar","illuvium","filecoin","helium","decentraland","monero","iota"]
    
    

    var body: some View{
        Picker("Currency", selection: $pickedCurrency) {
            ForEach(currencies, id: \.self) {
                Text("\($0)")
                }
        }
        .frame(width: 100.0, height: 25.0, alignment: .center)
        .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding()
        
        
    }
}


