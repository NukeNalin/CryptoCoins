//
//  HomeStatsView.swift
//  CryptoCoins
//
//  Created by Nalin iOS Developer on 19/06/21.
//

import SwiftUI

struct HomeStatsView: View {
    @Binding var statistics: [StatisticModel]
    @Binding var showProtfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width:UIScreen.main.bounds.width, alignment: showProtfolio ? .trailing : .leading)
        
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(statistics: .constant([]), showProtfolio: .constant(true))
    }
}
