//
//  ChartDataContainer.swift
//  Crasset
//
//  Created by daniele Muheim on 20.11.21.
//

import Foundation
import SwiftUI

@MainActor class ChartDataContainer : ObservableObject {
    @Published var totalInUSD: Float = 0.0
    let colorArray: [Color] = [Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)),Color(#colorLiteral(red: 0.9361220002, green: 0.9322158694, blue: 0, alpha: 1)),Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)),Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)),Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)),Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)),Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))]
    let emptyColor = Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    private var service: CoinCoreDataService?
    @Published var cryptoBalance:[String: Float] = [:]
    @Published var chartData : [ChartData] = [ChartData(color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), percent: 100, value: 10, cryptoID: "unknown")]
    
    func updateCoreData(service: CoinCoreDataService) async {
        self.service = service
        await calculatePercentages()
    }
    
    func calculatePercentages() async {
        guard let strongService = self.service else {
            return
        }
        totalInUSD = 0.0
        var index = 0
        for crypto in strongService.portfolio {
            let coinData = try? await APICaller.getSingleDetailsCrypto(cryptoID: SupportedCrypto.getCryptoKeyForAPI(key: crypto.cryptoID ?? ""))
            let priceInUSD = coinData?.USD ?? 0.0
            let balance = priceInUSD * crypto.amount
            self.totalInUSD += balance
            self.cryptoBalance[crypto.cryptoID ?? ""] = balance
        }

        chartData.removeAll()
        
        for asset in strongService.portfolio {
            let coinData = try? await APICaller.getSingleDetailsCrypto(cryptoID: SupportedCrypto.getCryptoKeyForAPI(key: asset.cryptoID ?? ""))
            let priceInUSD = coinData?.USD ?? 0.0
            self.chartData.append(ChartData(color: self.colorArray[index%6], percent: (CGFloat(asset.amount * priceInUSD / self.totalInUSD) * 100), value: (CGFloat(asset.amount * priceInUSD / self.totalInUSD) * 100), cryptoID:  asset.cryptoID ?? "unknown"))
            calc()
            index = index+1
        }
        
    }
    func calc(){
        var value : CGFloat = 0
        
        for i in 0..<chartData.count {
            value += chartData[i].percent
            chartData[i].value = value
        }
    }
    
}
