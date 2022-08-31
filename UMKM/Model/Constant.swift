//
//  Constant.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 24/08/22.
//

import Foundation
import SwiftUI

struct Constant{
    
}

struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: Double

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
}

extension Color {
  static let primaryGray = Color("primary_gray")
}

extension View {
    func scaledFont(name: String, size: Double) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
}
