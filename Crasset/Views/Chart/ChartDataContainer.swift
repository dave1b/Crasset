//
//  ChartDataContainer.swift
//  Crasset
//
//  Created by daniele Muheim on 20.11.21.
//

import Foundation
import SwiftUI

class ChartDataContainer : ObservableObject {
    @Published var totalInUSD = 0
    let colorArray: [Color] = [Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)),Color(#colorLiteral(red: 0.9361220002, green: 0.9322158694, blue: 0, alpha: 1)),Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)),Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)),Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)),Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)),Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))]
    let emptyColor = Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    @ObservedObject var service = AssetsView.shared
    //@EnvironmentObject var service: CoinCoreDataService
    @Published var chartData : [ChartData]
    
    init(){
        chartData = [ChartData(color: emptyColor, percent: 100, value: 0)]
        calculatePercentages()
    }
       // [ChartData(color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), percent: 10, value: 0)]
    
    func calculatePercentages(){
        var totalInUSD : Float = 0.0
        let index = 0
        var priceUSDDic: [String: Float] = [:]
        for crypto in service.portfolio {
            totalInUSD += priceInUSD(crypto: crypto.coinID!) * crypto.amount
            priceUSDDic[crypto.coinID!] = totalInUSD
        }
        chartData.removeAll()
        for crypto in service.portfolio {
            chartData.append(ChartData(color: colorArray[index%6], percent: (CGFloat(crypto.amount * priceUSDDic[crypto.coinID!]! / totalInUSD) * 100), value: 0))
        }
        
    }
    
    func priceInUSD(crypto: String) -> Float {
        var priceInUSD: Float = 0.0
        
        APICaller().getSingleDetailsCrypto(cryptoID: crypto){ (response) in
            let coinData = response
            priceInUSD = coinData.USD ?? 0.0
        }
        return priceInUSD
    }


}
