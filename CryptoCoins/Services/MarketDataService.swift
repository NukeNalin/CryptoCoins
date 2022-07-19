//
//  MarketDataService.swift
//  CryptoCoins
//
//  Created by Nalin Porwal on 20/06/21.
//

import Foundation
import Combine

class MarketDataService: ObservableObject {
    @Published var marketData: MarketDataModel?
    var cancellables: AnyCancellable?
    init() {
        getData()
    }

    private func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        cancellables = NetworkingManager.downloadWithDecoder(url, GlobalData.self)
            .sink { completion in
                NetworkingManager.handleCompletion(completion)
            } receiveValue: { [weak self] data in
                self?.marketData = data.data
                self?.cancellables?.cancel()
            }
    }

    deinit {
        cancellables?.cancel()
    }
}

