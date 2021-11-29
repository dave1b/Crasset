//
//  CalculatorView.swift
//  Crasset
//
//  Created by daniele Muheim on 18.11.21.
//

import SwiftUI

struct CalculatorView: View {
    @State var cryptoFiat1: CryptoFiat?
    @State var cryptoFiat2: CryptoFiat?
    @State private var amount1: String = ""
    @State private var amount2: String = ""
    @State private var pickedCurrency1 = "USD"
    @State private var pickedCurrency2 = "USD"
    
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .center){
                Spacer()
                VStack{
                    TextField(
                        "Currency 1",
                        text: $amount1)
                        .keyboardType(.numberPad)
                        .onChange(of: amount1) { newValue in
                            if newValue == amount1 {
                                amount1Changed()
                            }
                        }
                    
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                        .padding()
                    CurrencyPicker(parentView:  self , pickedCurrency: $pickedCurrency1)
                        .frame(width: 100.0, height: 25.0, alignment: .center)
                }
                
                Spacer()
                
                VStack{
                    TextField(
                        "Currency 2",
                        text: $amount2)
                        .keyboardType(.numberPad)
                        .onChange(of: amount1) { newValue in
                            if newValue == amount1 {
                                amount1Changed()
                            }
                        }
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                        .padding()
                    CurrencyPicker(parentView:  self ,pickedCurrency: $pickedCurrency2)
                        .frame(width: 100.0, height: 25.0, alignment: .center)
                }
                
                Spacer()
                
            }.task {
                APICaller().getSingleDetailsCrypto(cryptoID: SupportedCrypto.getCryptoKeyForAPI(key: pickedCurrency1)){ (response) in
                    cryptoFiat1 = response
                    //print(cryptoFiat1)
                }
                APICaller().getSingleDetailsCrypto(cryptoID: SupportedCrypto.getCryptoKeyForAPI(key: pickedCurrency2)){ (response) in
                    self.cryptoFiat2 = response
                }
            }
            .navigationTitle("Crypto Calculator")
        }
    }
    
    func amount1Changed() {
        APICaller().getSingleDetailsCrypto(cryptoID: SupportedCrypto.getCryptoKeyForAPI(key: pickedCurrency1)){ (response) in
            self.cryptoFiat1 = response
        }
        APICaller().getSingleDetailsCrypto(cryptoID: SupportedCrypto.getCryptoKeyForAPI(key: pickedCurrency2)){ (response) in
            self.cryptoFiat2 = response
        }
        let amount1AsFloat: Float = (Float(amount1) ?? 0.0)
        amount2 = String(format: "%.2f", amount1AsFloat * (cryptoFiat1?.USD ?? 0.0) / (cryptoFiat2?.USD ?? 0.0))
        print(amount2)
    }
    func amount2Changed() {
        // unimplemented
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
