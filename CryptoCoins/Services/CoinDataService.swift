//
//  CoinDataService.swift
//  CryptoCoins
//
//  Created by Nalin Porwal on 10/06/21.
//

import Combine
import Foundation
class CoinDataService: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    var cancellables: AnyCancellable?
    init() {
        getCoins()
    }

    private func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        cancellables = NetworkingManager.downloadWithDecoder(url, [CoinModel].self)
            .sink { completion in
                NetworkingManager.handleCompletion(completion)
            } receiveValue: { [weak self] coins in
                self?.allCoins = coins
            }
    }

    deinit {
        cancellables?.cancel()
    }
}
