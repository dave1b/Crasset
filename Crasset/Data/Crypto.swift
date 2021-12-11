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
    let amount: Float?
}
