//
//  AssetsView.swift
//  Crasset
//
//  Created by daniele Muheim on 18.11.21.
//

import SwiftUI

struct AssetsView: View {
    @State private var showingSheet = false
    @State private var cryptos: [Asset] = []
    @State var indexOfTappedSlice = -1
    @State var selection: Int? = nil
    
    @EnvironmentObject var service: CoinCoreDataService
    static let shared = CoinCoreDataService()
    @ObservedObject var charDataObj = ChartDataContainer()

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ForEach(0..<charDataObj.chartData.count) { index in

                        Circle()
                            .trim(from: index == 0 ? 0.0 : charDataObj.chartData[index-1].value/100,
                                  to: charDataObj.chartData[index].value/100)
                            .stroke(charDataObj.chartData[index].color,lineWidth: 50)
                            .onTapGesture {
                                indexOfTappedSlice = indexOfTappedSlice == index ? -1 : index
                            }
                            .scaleEffect(index == indexOfTappedSlice ? 1.1 : 1.0)
                    }
                    if indexOfTappedSlice != -1 {
                        Text(String(format: "%.2f", Double(charDataObj.chartData[indexOfTappedSlice].percent))+"%")
                            .font(.title)
                    }
                }
                .frame(width: 200, height: 250)
                .padding(.vertical)
                VStack{
                    List(service.portfolio){ crypto in
                        Text(crypto.coinID ?? "")
                        Text(String(format: "%.2f",  crypto.amount))
                    }
                    
                }
            }
            
            .navigationTitle("Assets")
            .toolbar {
                Button{
                    showingSheet.toggle()
                } label: {
                    Label("Edit", systemImage: "plus.circle.fill").font(.system(size: 25))
                        .foregroundColor(Color("ColorSet"))
                }
                .sheet(isPresented: $showingSheet) {
                    EditPortfolioView(showSheetView: self.$showingSheet)
                }
                
            }
        }
        
    }
    
}
    
struct AssetsView_Previews: PreviewProvider {
    static var previews: some View {
        AssetsView()
            .environmentObject(CoinCoreDataService())
    }
}
