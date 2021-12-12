//
//  APICaller.swift
//  Crasset
//
//  Created by Dave Brunner on 22.11.21.
//

import Foundation
import SwiftUI

struct APICaller {
    static let apiURLCoingecko = "https://api.coingecko.com/api/v3/"
    static let apiURLCryptoCompare = "https://min-api.cryptocompare.com/data/price?fsym="
    
    static func getSingleDetailsCrypto(cryptoID: String, completionHandler: @escaping (CryptoFiat) -> Void) {
        let url = URL(string: "\(APICaller.apiURLCryptoCompare)\(cryptoID)&tsyms=USD,CHF,EUR")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching cryptos: \(error)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      print("Error with the response, unexpected status code: \(String(describing: response))")
                      return
                  }
            if let data = data,
               let cryptoFiat = try? JSONDecoder().decode(CryptoFiat.self, from: data) {
                completionHandler(cryptoFiat)
            }
        })
        task.resume()
    }
    
    static func getAllCryptos(currencyID: String, completionHandler: @escaping ([Crypto]) -> Void) async {
        var url: String = "\(APICaller.apiURLCoingecko)coins/markets?vs_currency=\(currencyID)&ids="
        for crypto in SupportedCrypto.getsupportedCryptoArray() {
            url = "\(url)\(crypto)%2C%20"
        }
        url = "\(url)&order=market_cap_desc&per_page=100&page=1&sparkline=false"
        
        let finalUrl = URL(string: "\(url)")!
        let task = URLSession.shared.dataTask(with: finalUrl, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching cryptos: \(error)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      print("Error with the response, unexpected status code: \(String(describing: response))")
                      return
                  }
            if let data = data,
               let cryptos = try? JSONDecoder().decode([Crypto].self, from: data) {
                completionHandler(cryptos)
            }
        })
        task.resume()
    }
}
