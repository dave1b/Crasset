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
    @StateObject var charDataObj = ChartDataContainer()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ZStack {
                        ForEach(0..<charDataObj.chartData.count, id: \.self) { index in
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
                            Text(charDataObj.chartData[indexOfTappedSlice].cryptoID + " " + String(format: "%.2f", Double(charDataObj.chartData[indexOfTappedSlice].percent))+"%" )
                        }
                    }
                    .frame(width: 200, height: 250)
                    .padding(.vertical)
                    Text("Total Assets: " + String(charDataObj.totalInUSD) + " $")
                        .font(.title)
                    LazyVStack{
                        ForEach(service.portfolio){ crypto in
                            VStack {
                                HStack {
                                    Spacer()
                                    Text("Amount: " + String(format: "%.2f", crypto.amount))
                                }
                                HStack {
                                    Text(crypto.cryptoID ?? "")
                                        .font(.system(size: 25, weight: .bold, design: .default))
                                    Spacer()
                                    
                                }
                                HStack {
                                    Spacer()
                                    Text("Balance: " + String(format: "%.2f", charDataObj.cryptoBalance[crypto.cryptoID ?? ""] ?? 0.0) + " $")
                                }
                            }.font(.system(size: 14, weight: .bold, design: .default))
                                .foregroundColor(Color(UIColor.systemBackground))
                                .padding()
                        }
                        .frame(width: 350, height: 100.0)
                        .background(Color("ColorSet"))
                        .cornerRadius(20)
                        .padding([.leading, .trailing], 10.0)
                        .padding([.top, .bottom], 0)
                    }
                }
            }
            .toolbar {
                Button{
                    showingSheet.toggle()
                } label: {
                    Label("Edit", systemImage: "plus.circle.fill").font(.system(size: 25))
                        .foregroundColor(Color("ColorSet"))
                }
                .sheet(isPresented: $showingSheet, onDismiss: {
                    indexOfTappedSlice = -1
                    Task {
                        await charDataObj.calculatePercentages()
                    }
                    
                }) {
                    EditPortfolioView(showSheetView: self.$showingSheet)
                }
            }
            .navigationTitle("Assets")
            .navigationViewStyle(StackNavigationViewStyle())
        }
        
        .task {
            indexOfTappedSlice = -1
            await charDataObj.updateCoreData(service: service)
        }
    }
    
}

struct AssetsView_Previews: PreviewProvider {
    static var previews: some View {
        AssetsView()
            .environmentObject(CoinCoreDataService())
    }
}
