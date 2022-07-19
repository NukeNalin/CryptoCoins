//
//  CoinModel.swift
//  CryptoCoins
//
//  Created by Nalin iOS Developer on 30/05/21.
//

/*
 URL: https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h

 
 JSON Response
 
 {
     "id": "ethereum",
     "symbol": "eth",
     "name": "Ethereum",
     "image": "https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880",
     "current_price": 2545.5,
     "market_cap": 295828957778,
     "market_cap_rank": 2,
     "fully_diluted_valuation": null,
     "total_volume": 40713766749,
     "high_24h": 2636.43,
     "low_24h": 2479.41,
     "price_change_24h": 0.00040008,
     "price_change_percentage_24h": 0.00002,
     "market_cap_change_24h": -608023608.5635986,
     "market_cap_change_percentage_24h": -0.20511,
     "circulating_supply": 116230422.6865,
     "total_supply": null,
     "max_supply": null,
     "ath": 4356.99,
     "ath_change_percentage": -41.58364,
     "ath_date": "2021-05-12T14:41:48.623Z",
     "atl": 0.432979,
     "atl_change_percentage": 587733.63943,
     "atl_date": "2015-10-20T00:00:00.000Z",
     "roi": {
       "times": 91.36947729424816,
       "currency": "btc",
       "percentage": 9136.947729424815
     },
     "last_updated": "2021-06-10T07:01:55.119Z",
     "sparkline_in_7d": {
       "price": [
         2605.5921974713387,
         2581.1426091172425,
         2589.7180997790647,
         2568.8792754574997,
         2563.8619244026586
       ]
     },
     "price_change_percentage_24h_in_currency": 0.000015717284871917948
   },
 */


import Foundation
let coinDefaultiImgURL =  "https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880"
struct CoinModel: Identifiable, Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H: Double?
    let priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    func updateHoldings(amount: Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
    
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}
