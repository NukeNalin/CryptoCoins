//
//  HomeViewModel.swift
//  CryptoCoins
//
//  Created by Nalin Porwal on 10/06/21.
//

import Foundation
import Combine



class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = []
    @Published var allConins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let maketDataService = MarketDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscriber()
    }
    
    func addSubscriber() {
        $searchText.combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .map(filterCoin)
            .sink { [weak self] coinArray in
                self?.allConins = coinArray
            }.store(in: &cancellable)
        
        maketDataService.$marketData
            .map { marketData -> [StatisticModel] in
                var stat: [StatisticModel] = []
                guard let data = marketData else {
                    return stat
                }
                
                let marketCap = StatisticModel(title: "Market Cap", value: marketData?.marketCap ?? "", percentageChange: data.marketCapChangePercentage24HUsd)
                let volume =  StatisticModel(title: "24h Volume", value: data.volume)
                let btcDominace =  StatisticModel(title: "BTC Dominance", value: data.btcDominance)
                let portfolio = StatisticModel(title: "Portfolio Value", value: "₹0.0", percentageChange: 0)
                stat = [marketCap,volume,btcDominace,portfolio]
                return stat
                
            }.sink { [weak self] (stats) in
                self?.statistics = stats
            }.store(in: &cancellable)
    }
    
    private func filterCoin(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {return coins}
        let lowercaseText = text.lowercased()
        return coins.filter { coin -> Bool in
            return coin.name.lowercased().contains(lowercaseText) || coin.symbol.lowercased().contains(lowercaseText)
        }
    }
}
