//
//  PortfolioView.swift
//  CryptoCoins
//
//  Created by Nalin Porwal on 20/06/21.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    SearchBarView(searchText: $viewModel.searchText)
                    coinLogoList
                    if selectedCoin != nil {
                        portfolioSection
                    }
                }

            }.navigationTitle("Edit Portifolio")
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        XMarkButton()
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack(spacing: 10) {
                            Image(systemName: "checkmark")
                                .opacity(showCheckMark ? 1 : 0)
                            Button {
                                print("Save")
                                saveButtonPressed()
                            } label: {
                                Text("Save".uppercased())
                            }.opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0)
                        }
                    }
                })
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}

extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(viewModel.allConins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.greenColor : Color.clear, lineWidth: 1.0)
                        )
                }
            }
            .frame(height: 120)
            .padding(.leading)
        }
    }

    private var portfolioSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current Price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text("₹\(selectedCoin?.currentPrice.asCurrencyWithDecimals() ?? "")")
            }
            Divider()
            HStack {
                Text("Amount is holding:")
                Spacer()
                TextField("Ex:1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }

        }.padding()
            .font(.headline)
    }

    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0.0
    }
    
    private func saveButtonPressed() {
        guard let coin = selectedCoin else {
            return
        }
        /// Save to portfolio
        
        
        /// Show CheckMark
        withAnimation(.easeIn) {
            showCheckMark = true
        }
        
        // Hide Keyboard
        UIApplication.shared.endEditing()
        
        
        /// Hide Check Mark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                showCheckMark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        viewModel.searchText = ""
    }
}
