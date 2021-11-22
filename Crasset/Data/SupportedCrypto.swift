//
//  SupportedCrypto.swift
//  Crasset
//
//  Created by Dave Brunner on 22.11.21.
//

import Foundation


struct SupportedCrypto {

    
    private static let supportedCryptoArray : [String] = ["bitcoin", "ethereum", "binancecoin","solana","cardano","ripple","polkadot","dogecoin","shiba-inu","chainlink","matic-network","matic-network","uniswap","stellar","illuvium","filecoin","helium","decentraland","monero","iota"]

    static func getsupportedCryptoArray() -> [String] {
        return supportedCryptoArray
    }

}
