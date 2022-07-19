//
//  UIApplication.swift
//  CryptoCoins
//
//  Created by Nalin iOS Developer on 18/06/21.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
