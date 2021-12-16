//
//  EditPortfolioView.swift
//  Crasset
//
//  Created by daniele Muheim on 30.11.21.
//

import SwiftUI

struct EditPortfolioView: View {
    @State var selectedCoin: String = "Bitcoin"
    @State private var coinData: CryptoFiat?
    @State private var quantityText: String = ""
    @Binding var showSheetView: Bool
    @State private var totalValue: String = ""
    @EnvironmentObject var service: CoinCoreDataService
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                Spacer().frame(height: 75)
                VStack(spacing: 30) {
                    CurrencyPicker(pickedCurrency: $selectedCoin)
                        .onChange(of: selectedCoin, perform: { value in
                            if value == selectedCoin {
                                Task{
                                    await amount1Changed()
                                    quantityText = String(format: "%.2f", service.getAmountOfCoin(cryptoID: value))
                                }
                            }
                        })
                    Spacer()
                    HStack {
                        Text("Amount holding:" )
                        Spacer()
                        TextField("", text: $quantityText)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                    }
                    Divider()
                    HStack {
                        Text("Current price of \(selectedCoin):")
                        Spacer()
                        Text(String(format: "%.2f", coinData?.USD ?? 0.0) + " $")
                    }
                    
                    Divider()
                    HStack {
                        Text("Your holdings value")
                        Spacer()
                        Text(totalValue + " $")
                    }
                    Spacer()
                }
                .padding()
                .padding()
                
                .font(.headline)
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
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
                    Task{
                        await amount1Changed()
                    }
                }
            }
        } .task {
            await amount1Changed()
            quantityText = String(format: "%.2f", service.getAmountOfCoin(cryptoID: selectedCoin))
        }
        
    }
    
    func amount1Changed() async {
        coinData = try? await APICaller.getSingleDetailsCrypto(cryptoID: SupportedCrypto.getCryptoKeyForAPI(key: selectedCoin))
        let amount1AsFloat: Float = (Float(quantityText) ?? 0.0)
        totalValue = String(format: "%.2f", amount1AsFloat * (coinData?.USD ?? 0.0))
        
    }
    
    func saveButtonPressed() {
        if(quantityText != "") {
            service.updateAssets(cryptoID: selectedCoin, amount: Float(quantityText)!)
        }
    }
}


struct EditPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        EditPortfolioView(showSheetView: .constant(true))
    }
}
