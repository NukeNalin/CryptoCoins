//
//  StatisticView.swift
//  CryptoCoins
//
//  Created by Nalin iOS Developer on 19/06/21.
//

import SwiftUI

struct StatisticView: View {
    var stat: StatisticModel
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
            Text(stat.value)
                .foregroundColor(Color.theme.accentColor)
            HStack {
                if stat.percentageChange != nil {
                Image(systemName: "triangle.fill")
                    .font(.caption)
                    .rotationEffect(Angle(degrees:
                                            (stat.percentageChange ?? 0) >= 0 ? 0
                        :180
                    ))
            }
                Text(stat.percentageChange?.asNumberString() ?? "")
                    .font(.caption)
                    .bold()
            }.foregroundColor(
                (stat.percentageChange ?? 0) >= 0 ? Color.theme.greenColor : Color.theme.redColor
                    .opacity(stat.percentageChange == nil ? 0.0 : 1)
            )
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(stat: dev.stat1)
    }
}
