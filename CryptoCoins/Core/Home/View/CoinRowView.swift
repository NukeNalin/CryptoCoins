//
//  CoinRowView.swift
//  CryptoCoins
//
//  Created by Nalin Porwal on 10/06/21.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showHoldingColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
            if showHoldingColumn { centerColumn }
            rightColumn
        }.font(.subheadline)
    }
}


extension CoinRowView {
    private var leftColumn: some View {
        HStack {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accentColor)
        }
    }
    
    
    private var centerColumn: some View {
        VStack(alignment:.trailing){
            Text(coin.currentHoldingsValue.asCurrencyWithDecimals())
            Text((coin.currentHoldings ?? 0 ).asNumberString())
        }
        .foregroundColor(Color.theme.accentColor)
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing){
            Text("₹\(coin.currentPrice.asCurrencyWithDecimals())")
                .bold()
                .foregroundColor(Color.theme.accentColor)
            Text("\(coin.priceChangePercentage24H?.asPercentSring() ?? "")")
                .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.greenColor : Color.theme.redColor)
        }
        .frame(width: UIScreen.main.bounds.width/3.5, alignment: .trailing)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin, showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
            
            CoinRowView(coin: dev.coin, showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        
    }
}
