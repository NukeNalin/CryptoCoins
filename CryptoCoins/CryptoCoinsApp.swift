//
//  CryptoCoinsApp.swift
//  CryptoCoins
//
//  Created by Nalin iOS Developer on 30/05/21.
//

import SwiftUI

@main
struct CryptoCoinsApp: App {
    @StateObject private var viewModel = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }.environmentObject(viewModel)
        }
    }
}
