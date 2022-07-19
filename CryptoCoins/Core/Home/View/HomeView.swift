//
//  Home.swift
//  CryptoCoins
//
//  Created by Nalin iOS Developer on 30/05/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var showPortfolio: Bool = false // To Animate
    @State private var showPorfolioView: Bool = false
    @State var searchText: String = ""
    var body: some View {
        ZStack {
            /// `Background Layer `
            Color.theme.backgroundColor
                .ignoresSafeArea()
                .sheet(isPresented: $showPorfolioView, content: {
                    PortfolioView()
                        .environmentObject(viewModel)
                })
            /// `Content Layer `
            VStack {
                headerView
                HomeStatsView(statistics: $viewModel.statistics, showProtfolio: $showPortfolio)
                SearchBarView(searchText: $viewModel.searchText)
                
                HStack {
                    Text("Coins")
                    Spacer()
                    if showPortfolio {
                    Text("Holding")
                    }
                    Text("Price")
                        .frame(width: UIScreen.main.bounds.width/3.5, alignment: .trailing)
                }.font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
                .padding(.horizontal)
                
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                if showPortfolio{
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                
               
                Spacer(minLength: 0)
            }
        }
    }
}


extension HomeView {
    private var headerView: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    if showPortfolio {
                        showPorfolioView.toggle()
                    }
                }
                .background(CircleButtonAnimtionView(animate: $showPortfolio))

            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accentColor)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }.padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List{
            ForEach(viewModel.allConins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }.listStyle(PlainListStyle())
    }
    
    
    private var portfolioCoinsList: some View {
        List{
            ForEach(viewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }.listStyle(PlainListStyle())
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(dev.homeView)
    }
}
