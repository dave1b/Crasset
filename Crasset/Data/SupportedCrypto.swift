//
//  SupportedCrypto.swift
//  Crasset
//
//  Created by Dave Brunner on 22.11.21.
//

import Foundation

struct SupportedCrypto {
    
    private static let supportedCryptoArray : [String] = ["bitcoin", "ethereum", "binancecoin","solana","cardano","ripple","polkadot","dogecoin","shiba-inu","chainlink","matic-network","matic-network","uniswap","stellar","illuvium","filecoin","helium","decentraland","monero","iota"]
    
    private static let  api2:[String:String] = ["USD":"USD","CHF":"CHF","EUR":"EUR","Bitcoin":"btc", "Ethereum":"eth", "Binancecoin":"bnb","Solana":"sol","Cardano":"ada","Ripple":"xrp","Polkadot":"dot","Dogecoin":"doge","Shiba-Inu":"shib","Chainlink":"link","Matic-network":"matic","Uniswap":"uni","Stellar":"xlm","Illuvium":"ilv","Filecoin":"fil","Helium":"hnt","Decentraland":"mana","Monero":"xmr","Iota":"miota"]
    
    static func getsupportedCryptoArray() -> [String] {
        return supportedCryptoArray
    }
    
    static func getCryptoKeyForAPI(key: String) -> String {
        return api2[key]!
    }
}
