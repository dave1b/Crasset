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
    @State private var amount1: String = "0.0"
    @State private var amount2: String = "0.0"
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
                    CurrencyPicker(pickedCurrency: $pickedCurrency1)
                        .frame(width: 100.0, height: 25.0, alignment: .center)
                        .onChange(of: pickedCurrency1, perform: { value in
                                picker1Changed()
                        })
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
                    CurrencyPicker(pickedCurrency: $pickedCurrency2)
                        .frame(width: 100.0, height: 25.0, alignment: .center)
                        .onChange(of: pickedCurrency2, perform: { value in
                            if value == pickedCurrency2 {
                                picker2Changed()
                            }
                        })
                }
                
                Spacer()
                
            }.task {
                APICaller().getSingleDetailsCrypto(cryptoID: SupportedCrypto.getCryptoKeyForAPI(key: pickedCurrency1)){ (response) in
                    cryptoFiat1 = response
                }
                APICaller().getSingleDetailsCrypto(cryptoID: SupportedCrypto.getCryptoKeyForAPI(key: pickedCurrency2)){ (response) in
                    cryptoFiat2 = response
            }
            }
            .navigationTitle("Crypto Calculator")
        }
    }
    
    func picker1Changed() {
        APICaller().getSingleDetailsCrypto(cryptoID: SupportedCrypto.getCryptoKeyForAPI(key: pickedCurrency1)){ (response) in
            cryptoFiat1 = response
            amount1Changed()
        }
    }
    
    func picker2Changed(){
        APICaller().getSingleDetailsCrypto(cryptoID: SupportedCrypto.getCryptoKeyForAPI(key: pickedCurrency2)){ (response) in
            cryptoFiat2 = response
            amount2Changed()
        }
    }
    
    
    func amount1Changed() {
            let amount1AsFloat: Float = (Float(amount1) ?? 0.0)
            amount2 = String(format: "%.2f", amount1AsFloat * (cryptoFiat1?.USD ?? 0.0) / (cryptoFiat2?.USD ?? 0.0))
            print(amount2)
    }
    func amount2Changed() {
            let amount2AsFloat: Float = (Float(amount2) ?? 0.0)
            amount1 = String(format: "%.2f", amount2AsFloat * (cryptoFiat2?.USD ?? 0.0) / (cryptoFiat1?.USD ?? 0.0))
            print(amount1)
        }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
