//
//  APICaller.swift
//  Crasset
//
//  Created by Dave Brunner on 22.11.21.
//

import Foundation
import SwiftUI

final class APICaller {
    
    var apiURL = "https://api.coingecko.com/api/v3/"
    
    static func getSingleDetailsCrypto(completionHandler: @escaping (Crypto) -> Void, cryptoID: String, currencyID: String) {
        let url = URL(string: "(apiURL)coins/markets?vs_currency=(currencyID)&ids=/(cryptoID)")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching films: \(error)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      print("Error with the response, unexpected status code: \(String(describing: response))")
                      return
                  }
            if let data = data,
               let crypto = try? JSONDecoder().decode(Crypto.self, from: data) {
                completionHandler(crypto)
            }
        })
        task.resume()
    }
    
    
    static func getAllCryptos(currencyID: String, completionHandler: @escaping ([Crypto]) -> Void) {
        var url: String = (apiURL)+coins/markets?vs_currency=(currencyID)&ids=/"
        for crypto in SupportedCrypto.getsupportedCryptoArray() {
            print (crypto)
            url = "(url)(crypto)%2C%20"
            print(url)
        }
        url = "(url)&order=market_cap_desc&per_page=100&page=1&sparkline=false"
        print(url)
        
        let finalUrl = URL(string: "(url)")!
        let task = URLSession.shared.dataTask(with: finalUrl, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching films: \(error)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      print("Error with the response, unexpected status code: \(String(describing: response))")
                      return
                  }
            if let data = data,
               let cryptoArray = try? JSONDecoder().decode([Crypto].self, from: data) {
                completionHandler(cryptoArray)
            }
        })
        task.resume()
    }
    
    
}
