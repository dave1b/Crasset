//
//  AssetsChart.swift
//  Crasset
//
//  Created by daniele Muheim on 20.11.21.
//

import SwiftUI

struct AssetsChart: View {
    @ObservedObject var charDataObj = ChartDataContainer()
    @State var indexOfTappedSlice = -1
    @State var selection: Int? = nil
    
    var body: some View {
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
            .onAppear() {
                self.charDataObj.calc()
            }
            HStack{
                Text("Cryptos")
                    .padding(.trailing)
                    .font(.system(size: 20))
                    .foregroundColor(.blue)
                NavigationLink(destination: AllMyCryptosView(), tag: 1, selection: $selection) {
                    Button {
                        self.selection = 1

                    } label: {
                        Text("Show all my Cryptos")
                            .padding()
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .background(Color("ColorSet"))
                    }.cornerRadius(20)
                        .padding(.leading)
                }
            }
        }
    }
}

struct AssetsChart_Previews: PreviewProvider {
    static var previews: some View {
        AssetsChart()
    }
}
