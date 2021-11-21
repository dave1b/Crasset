//
//  CryptocurrenciesView.swift
//  Crasset
//
//  Created by daniele Muheim on 18.11.21.
//

import SwiftUI

struct CryptocurrenciesView: View {
    @State private var avatarImage = UIImage(named: "Bitcoin")!
    
    var body: some View {
        NavigationView {
            HStack(alignment: .center) {
                Image(uiImage: avatarImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                    .padding([.top, .leading, .bottom], 15)
                
                VStack(alignment: .leading) {
                    Group {
                        HStack {
                            Text("Bitcoin (BTC)")
                            Spacer()
                            Text("$60.383,7")
                        }
                    }
                    .font(.system(size: 13, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .padding(.all, 15)
                    HStack {
                        Spacer()
                        Text("-8,36%")                    .font(.system(size: 13, weight: .bold, design: .default))
                            .foregroundColor(.red)
                    }.padding()
                    
                }
                Spacer()
            }        .frame(height: 100.0)

            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color("ColorSet"))
            .cornerRadius(20)
            .padding(.all, 10)
            .navigationBarTitle(Text("All Cryptocurrencies").font(.subheadline))
            
   
        }
    }
}

struct CryptocurrenciesView_Previews: PreviewProvider {
    static var previews: some View {
        CryptocurrenciesView()
    }
}
