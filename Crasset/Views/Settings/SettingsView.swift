//
//  SettingsView.swift
//  Crasset
//
//  Created by daniele Muheim on 18.11.21.
//

import SwiftUI

struct SettingsView: View {
    @State private var selectedCurrency = "USD"
    @State private var selctedCrypto = "Ethereum"
    
    let currencies = ["USD", "CHF", "EURO"]
    let cryptos = ["Bitcoin", "Ethereum", "Solana"]
    var body: some View {
        
        VStack {
            Color("ColorSet").frame(height: 150)
            
            CircleProfile()
                .offset(x: 0, y: -75)
                .padding(.bottom, -75)
            
            VStack(alignment: .center) {
                Text("Ben McMahen").font(.title)
                Text("ben.McMahen@gmail.com")
                    .padding()
                    .font(.body)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
            }
            
            VStack {
                HStack{
                    Text("Currency:")
                    Section {
                        Picker("Currency", selection: $selectedCurrency) {
                            ForEach(currencies, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                }
                HStack{
                    Text("Currency:")
                    Section {
                        Picker("Currency", selection: $selctedCrypto) {
                            ForEach(cryptos, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                }
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                    }) {
                        Image(systemName: "pencil.circle.fill").imageScale(.large)
                            .font(.system(size: 40))
                            .foregroundColor(Color("ColorSet"))
                        
                    }.padding()
                    
                }
            }
            Spacer()
        }
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
