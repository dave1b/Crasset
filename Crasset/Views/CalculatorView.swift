//
//  CalculatorView.swift
//  Crasset
//
//  Created by daniele Muheim on 18.11.21.
//

import SwiftUI

struct CalculatorView: View {
    @State var crypto: [Crypto]?
    @State private var amount1 = ""
    @State private var amount2 = ""
    @State private var pickedCurrency1 = ""
    @State private var pickedCurrency2 = ""
    
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .center){
                Spacer()
                VStack{
                    TextField(
                        "Currency 1",
                        text: $amount1)
                        .onChange(of: amount1) { newValue in
                            if newValue == amount1 {
                                amount1Changed()
                            }
                        }
                    
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                        .padding()
                    CurrencyPicker(pickedCurrency: $pickedCurrency1)
                        .frame(width: 100.0, height: 25.0, alignment: .center)
                }
                
                Spacer()
                
                VStack{
                    TextField(
                        "Currency 2",
                        text: $amount2)
                        .onChange(of: amount1) { newValue in
                            if newValue == amount1 {
                                amount1Changed()
                            }
                        }
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                        .padding()
                    CurrencyPicker(pickedCurrency: $pickedCurrency2)
                        .frame(width: 100.0, height: 25.0, alignment: .center)
                }
                
                Spacer()
                
                
                
                
                
                
                
            }.navigationTitle("Crypto Calculator")
        }
    }
    
    @MainActor func amount1Changed() {
        APICaller().getSingleDetailsCrypto(cryptoID: "bitcoin", currencyID: "usd"){ cryptos in
            self.crypto = cryptos
        }
        amount2 = String(crypto?[0].usd[0] ?? 2.0)
        print("Name changed to \(amount1)!")
    }
    func amount2Changed() {
        print("Name changed to \(amount2)!")
    }
    
}



struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
