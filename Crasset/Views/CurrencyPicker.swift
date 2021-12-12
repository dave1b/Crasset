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
    
    var currencies = ["USD","CHF","EUR","Bitcoin", "Ethereum", "Binancecoin","Solana","Cardano","Ripple","Polkadot","Dogecoin","Shiba-Inu","Chainlink","Matic-network","Uniswap","Stellar","Illuvium","Filecoin","Helium","Decentraland","Monero","Iota"]
    
    var body: some View{
        Picker("Currency", selection: $pickedCurrency) {
            ForEach(currencies, id: \.self) {
                Text("\($0)")
            }
        }.pickerStyle(WheelPickerStyle())
        .frame(width: 150.0, height: 75.0, alignment: .center)
        .padding()
        .background(lightGreyColor)
        .cornerRadius(5.0)
        .padding()
    }
}
