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
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Spacer().frame(height: 50)
                    CurrencyPicker(pickedCurrency: $selectedCoin)
                        .frame(width: 100.0, height: 25.0, alignment: .center)
                        .padding(.all, 20)
                        .onChange(of: selectedCoin, perform: { value in
                            if value == selectedCoin {
                                Task{
                                    await amount1Changed()
                                    quantityText = String(format: "%.2f", service.getAmountOfCoin(cryptoID: value))
                                }
                            }
                        })
                    Spacer().frame(height: 50)
                    HStack {
                        Text("Current price of \(selectedCoin):")
                        Spacer()
                        Text(String(format: "%.2f", coinData?.USD ?? 0.0))
                    }
                    Divider()
                    HStack {
                        Text("Amount holding:" )
                        Spacer()
                        TextField("", text: $quantityText)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                    }
                    Divider()
                    HStack {
                        Text("Holding in USD")
                        Spacer()
                        Text(totalValue)
                    }
                    Spacer()
                }
                .padding()
                .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .cornerRadius(20)
                .padding()

                .font(.headline)
                
            }
            .background(Color(#colorLiteral(red: 0.7303430678, green: 0.7596959392, blue: 0.6726173771, alpha: 1)))
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
        service.updatePortfolio(cryptoID: selectedCoin, amount: Float(quantityText)!)
    }
}


struct EditPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        EditPortfolioView(showSheetView: .constant(true))
    }
}
