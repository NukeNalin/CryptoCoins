//
//  CoinImageViewModel.swift
//  CryptoCoins
//
//  Created by Nalin Porwal on 10/06/21.
//

import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isloading: Bool = true
    private var fileManager = LocalFileManager.shared
    private let coin: CoinModel
    var imageSubscriber: AnyCancellable?
    private let folderName = "coin_images"
    
    init(_ coin: CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage () {
        if let image = fileManager.getImage(imageName: coin.id, folderName: folderName) {
            self.image = image
            print("Retrive Images From FileManager!")
        } else {
            downloadImage(URL(string: coin.image)!)
        }
    }
    
    private func downloadImage(_ url: URL) {
        print("Download image now")
    
        imageSubscriber = NetworkingManager.download(url)
            .sink(receiveCompletion: { NetworkingManager.handleCompletion($0) { [weak self] in
                self?.isloading = false
            }
            }, receiveValue: { [weak self] data in
                self?.image = UIImage(data: data)!
                self?.fileManager.savedImage(image: (self?.image)!, imageName: self!.coin.id, folderName: self!.folderName)
            })
    }
}
