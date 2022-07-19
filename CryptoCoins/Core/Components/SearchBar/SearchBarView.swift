//
//  SearchBarView.swift
//  CryptoCoins
//
//  Created by Nalin iOS Developer on 18/06/21.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String

    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? Color.theme.secondaryTextColor :
                                    Color.theme.accentColor
                )
            TextField("Serach by name or symbol...", text: $searchText)
                .foregroundColor(Color.theme.accentColor)
                .disableAutocorrection(true)
                .overlay(
                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .offset(x: 10)
                    .foregroundColor(Color.theme.accentColor)
                    .opacity(searchText.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                        searchText = ""
                    }
                    ,alignment: .trailing
                )
        }.font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.backgroundColor)
                .shadow(color: Color.theme.accentColor.opacity(0.15), radius: 10, x: 0, y: 0)
        ).padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
