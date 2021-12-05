//
//  EditPortfolioView.swift
//  Crasset
//
//  Created by daniele Muheim on 30.11.21.
//

import SwiftUI

struct EditPortfolioView: View {
    @State var selectedCoin: String = ""
    @State private var coinData: CryptoFiat?
    @State private var quantityText: String = ""
    @Binding var showSheetView: Bool
    @State private var totalValue: String = ""
    @EnvironmentObject var service: CoinCoreDataService
    @ObservedObject var charDataObj = ChartDataContainer()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    CurrencyPicker(pickedCurrency: $selectedCoin)
                        .frame(width: 100.0, height: 25.0, alignment: .center)
                        .padding(.all, 20)
   
                    HStack {
                        Text("Current price of \(selectedCoin):")
                        Spacer()
                        Text(String(format: "%.2f", coinData?.USD ?? 0.0))
                    }
                    .onChange(of: selectedCoin, perform: { value in
                        if value == selectedCoin {
                            amount1Changed()
                        }
                    })
                    
                    Divider()
                    HStack {
                        Text("Amount holding:" )
                        Spacer()
                        TextField("Ex: 1.4", text: $quantityText)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                    }

                    Divider()
                    HStack {
                        Text("Current value:")
                        Spacer()
                        Text(totalValue)
                    }
                }
                .padding()
                .font(.headline)
                
            }
            .navigationBarTitle(Text("Edit Portfolio"))
            .navigationBarItems(leading: Button(action: {
                self.showSheetView = false
            }, label: {
                Label("Edit", systemImage: "xmark.circle.fill").font(.system(size: 25))
                    .foregroundColor(Color("ColorSet"))
            }))
            .navigationBarItems(trailing: Button(action: {
                saveButtonPressed()
                self.showSheetView = false
            }, label: {
                Text("SAVE").bold()
            }))

            .onChange(of: quantityText) { newValue in
                if newValue == quantityText {
                    amount1Changed()
                }
            }
        }
    }
    
    func amount1Changed() {
        APICaller().getSingleDetailsCrypto(cryptoID: SupportedCrypto.getCryptoKeyForAPI(key: selectedCoin)){ (response) in
            coinData = response
            let amount1AsFloat: Float = (Float(quantityText) ?? 0.0)
            totalValue = String(format: "%.2f", amount1AsFloat * (coinData?.USD ?? 0.0))
        }
        
    }
    
    func saveButtonPressed() {
        self.charDataObj.add()
        service.updatePortfolio(coin: selectedCoin, amount: Float(quantityText)!)
    }
}


struct EditPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        EditPortfolioView(showSheetView: .constant(true))
    }
}