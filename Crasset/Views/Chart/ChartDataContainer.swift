//
//  ChartDataContainer.swift
//  Crasset
//
//  Created by daniele Muheim on 20.11.21.
//

import Foundation
import SwiftUI

class ChartDataContainer : ObservableObject {
    @Published var chartData =
        [ChartData(color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), percent: 10, value: 0)]
    
    
    func calc(){
        var value : CGFloat = 0
        
        for i in 0..<chartData.count {
            value += chartData[i].percent
            chartData[i].value = value
        }
    }
    
    func add(){
        chartData.append(ChartData(color: Color(.blue), percent: 45, value: 200))
        print (chartData)
    }
}
