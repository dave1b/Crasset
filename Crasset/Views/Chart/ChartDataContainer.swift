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
    @Published var chartDataObj : ChartData = ChartData(color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), percent: 10, value: 10)
    @State var cryptoFiat: CryptoFiat?
    let colorArray: [Color] = [Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)),Color(#colorLiteral(red: 0.9361220002, green: 0.9322158694, blue: 0, alpha: 1)),Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)),Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)),Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)),Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)),Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))]
    let emptyColor = Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    @ObservedObject var service = AssetsView.shared
    //@EnvironmentObject var service: CoinCoreDataService
    @Published var chartData : [ChartData] = [ChartData(color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), percent: 10, value: 10)]
    
    init(){
        calculatePercentages()
    }
    // [ChartData(color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), percent: 10, value: 0)]
    
    func calculatePercentages(){
        var totalInUSD : Float = 0.0
        var index = 0
        
        for crypto in service.portfolio {
            APICaller().getSingleDetailsCrypto(cryptoID: SupportedCrypto.getCryptoKeyForAPI(key: crypto.coinID ?? "")){ (response) in
                let coinData = response
                let priceInUSD = coinData.USD ?? 0.0
                totalInUSD += priceInUSD * crypto.amount
            }
        }
        //print(chartData[0])
            chartData.removeAll()
        //chartData.append(ChartData(color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), percent: 60, value: 60))
            for asset in service.portfolio {
                APICaller().getSingleDetailsCrypto(cryptoID: SupportedCrypto.getCryptoKeyForAPI(key: asset.coinID ?? "")){ [self] (response) in
                    cryptoFiat = response
                    let priceInUSD = cryptoFiat?.USD ?? 0.0
                    //print((asset.amount * priceInUSD / totalInUSD) * 100)
                    print(ChartData(color: self.colorArray[index%6], percent: (CGFloat(asset.amount * priceInUSD / totalInUSD) * 100), value: (CGFloat(asset.amount * priceInUSD / totalInUSD) * 100)))
                    chartDataObj = ChartData(color: self.colorArray[index%6], percent: (CGFloat(asset.amount * priceInUSD / totalInUSD) * 100), value: (CGFloat(asset.amount * priceInUSD / totalInUSD) * 100))
            }
                chartData.append(chartDataObj)
                index = index+1
                print(index)
                print(chartDataObj)
            }
    }
}
