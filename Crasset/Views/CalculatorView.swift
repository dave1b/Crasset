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
    @State private var amount1: String = "0.00"
    @State private var amount2: String = "0.00"
    @State private var pickedCurrency1 = "USD"
    @State private var pickedCurrency2 = "USD"
    @State private var isFocused1 = false
    @State private var isFocused2 = false
    @FocusState private var amountIsFocused: Bool
    @FocusState private var picker1Changed: Bool
    @FocusState private var picker2Changed: Bool
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                Spacer()
                VStack{
                    CurrencyPicker(pickedCurrency: $pickedCurrency1)
                        .onChange(of: pickedCurrency1, perform: { value in
                            Task{
                                await picker1Changed()
                            }
                        }) .padding([.bottom], -10.0)
                }
                TextField(
                    "Currency 1",
                    text: $amount1, onEditingChanged: { (changed) in
                        isFocused1 = changed
                    })
                    .keyboardType(.numberPad)
                    .focused($amountIsFocused)
                    .onChange(of: amount1) { newValue in
                        if isFocused1 && !picker1Changed  {
                            Task{
                                await amount1Changed()
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10.0)
                    .padding()
                
                Image(systemName: "arrow.up.arrow.down").resizable().frame(width: 40, height: 40).padding(5)
                
                VStack{
                    TextField(
                        "Currency 2",
                        text: $amount2, onEditingChanged: { (changed) in
                            isFocused2 = changed
                        })
                        .keyboardType(.numberPad)
                        .focused($amountIsFocused)
                        .onChange(of: amount2) { newValue in
                            if isFocused2 && !picker2Changed {
                                Task{
                                    await amount2Changed()
                                }
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10.0)
                        .padding()
                        .padding([.bottom], -10.0)
                    
                    CurrencyPicker(pickedCurrency: $pickedCurrency2)
                        .onChange(of: pickedCurrency2, perform: { value in
                            if value == pickedCurrency2 {
                                Task{
                                    await picker2Changed()
                                }
                            }
                        })
                }
                Spacer()
                
            }.task {
                cryptoFiat1 = try? await APICaller.getSingleDetailsCrypto(cryptoID: SupportedCrypto.getCryptoKeyForAPI(key: pickedCurrency1))
                cryptoFiat2 = try? await APICaller.getSingleDetailsCrypto(cryptoID: SupportedCrypto.getCryptoKeyForAPI(key: pickedCurrency2))
            }
            .background(Color(#colorLiteral(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)))
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }.navigationTitle("Crypto Calculator")
            
        }
    }
    
    func picker1Changed() async {
        picker1Changed = true
        cryptoFiat1 = try? await APICaller.getSingleDetailsCrypto(cryptoID: SupportedCrypto.getCryptoKeyForAPI(key: pickedCurrency1))
        await amount2Changed()
        picker1Changed = false
    }
    
    func picker2Changed() async {
        picker2Changed = true
        cryptoFiat2 = try? await APICaller.getSingleDetailsCrypto(cryptoID: SupportedCrypto.getCryptoKeyForAPI(key: pickedCurrency2))
        await amount1Changed()
        picker2Changed = false
    }
    
    func amount1Changed() async {
        let amount1AsFloat: Float = (Float(amount1) ?? 0)
        amount2 = String(format: "%.2f", amount1AsFloat * (cryptoFiat1?.USD ?? 0.0) / (cryptoFiat2?.USD ?? 0.0))
    }
    
    func amount2Changed() async {
        let amount2AsFloat: Float = (Float(amount2) ?? 0)
        amount1 = String(format: "%.2f", amount2AsFloat * (cryptoFiat2?.USD ?? 0.0) / (cryptoFiat1?.USD ?? 0.0))
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
