//
//  CircleButtonAnimtionView.swift
//  CryptoCoins
//
//  Created by Nalin iOS Developer on 30/05/21.
//

import SwiftUI

struct CircleButtonAnimtionView: View {
    @Binding var animate: Bool
    var body: some View {
        Circle()
            .stroke( lineWidth: 5.0 )
            .scale(animate ? 1 : 0 )
            .opacity(animate ? 0 : 1)
            .animation( animate ? Animation.easeIn(duration: 1) : .none)
            
    }
}

struct CircleButtonAnimtionView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimtionView(animate: .constant(true))
    }
}
