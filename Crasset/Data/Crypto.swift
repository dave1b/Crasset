//
//  Crypto.swift
//  Crasset
//
//  Created by Dave Brunner on 22.11.21.
//

import Foundation

struct Crypto: Decodable  {
    let id: String?
    let name: String?
    let symbol: String?
    let image: String?
    let current_price: Float?
    let market_cap: Float?
    let market_cap_rank: Int?
    let total_volume: Float?
    let price_change_percentage_24h: Float?
    let ath: Float?
    
}
/*
 {
 "id": "ethereum",
 "symbol": "eth",
 "name": "Ethereum",
 "image": "https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880",
 "current_price": 4196.53,
 "market_cap": 496572676532,
 "market_cap_rank": 2,
 "fully_diluted_valuation": null,
 "total_volume": 17780167508,
 "high_24h": 4444.53,
 "low_24h": 4150.66,
 "price_change_24h": -172.063918811248,
 "price_change_percentage_24h": -3.93865,
 "market_cap_change_24h": -21566309479.378967,
 "market_cap_change_percentage_24h": -4.16226,
 "circulating_supply": 118441434.3115,
 "total_supply": null,
 "max_supply": null,
 "ath": 4878.26,
 "ath_change_percentage": -13.84342,
 "ath_date": "2021-11-10T14:24:19.604Z",
 "atl": 0.432979,
 "atl_change_percentage": 970603.81744,
 "atl_date": "2015-10-20T00:00:00.000Z",
 "roi": {
 "times": 96.80929437436052,
 "currency": "btc",
 "percentage": 9680.929437436052
 },
 "last_updated": "2021-11-22T08:11:45.798Z"
 },*/
