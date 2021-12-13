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
    
    static func getSingleDetailsCrypto(cryptoID: String) async throws -> CryptoFiat {
        let url = URL(string: "\(APICaller.apiURLCryptoCompare)\(cryptoID)&tsyms=USD,CHF,EUR")!
        let session = URLSession.shared
        let (data, _) = try await session.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(CryptoFiat.self, from: data)
    }
    
    static func getAllCryptos(currencyID: String) async throws -> [Crypto] {
        var url: String = "\(APICaller.apiURLCoingecko)coins/markets?vs_currency=\(currencyID)&ids="
        for crypto in SupportedCrypto.getsupportedCryptoArray() {
            url = "\(url)\(crypto)%2C%20"
        }
        url = "\(url)&order=market_cap_desc&per_page=100&page=1&sparkline=false"
        let finalUrl = URL(string: url)!

        let session = URLSession.shared
        let (data, _) = try await session.data(from: finalUrl)
        let decoder = JSONDecoder()
        return try decoder.decode([Crypto].self, from: data)
    }
}
