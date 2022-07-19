//
//  ContentView.swift
//  CryptoCoins
//
//  Created by Nalin iOS Developer on 30/05/21.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            VStack {
                Text("First")
                    .foregroundColor(Color.theme.greenColor)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        ContentView()
            .preferredColorScheme(.dark)
        }
    }
}
