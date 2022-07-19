//
//  CircleButtonView.swift
//  CryptoCoins
//
//  Created by Nalin iOS Developer on 30/05/21.
//

import SwiftUI

struct CircleButtonView: View {
    var iconName: String
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accentColor)
            .frame(width: 50, height: 50, alignment: .center)
            .background(
            Circle()
                .foregroundColor(Color.theme.backgroundColor)
            ).shadow(color: Color.theme.accentColor.opacity(0.25), radius: 10, x: 0.0, y: 0.0)
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(iconName: "info")
                .padding()
                .previewLayout(.sizeThatFits)
            
            CircleButtonView(iconName: "plus")
                .preferredColorScheme(.dark)
                .padding()
                .previewLayout(.sizeThatFits)
        }
        
    }
}
