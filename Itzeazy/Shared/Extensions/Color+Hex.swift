//
//  Color+Hex.swift
//  Itzeazy
//
//  Created by Nazmin Parween on 28/04/26.
//

import SwiftUI

extension Color {
    static let screenBackground = Color(hex: "#FAFBFD")
      static let menuIconTint = Color(hex: "#9AA1AF")
      static let locationText = Color(hex: "#3E4654")
      static let searchPlaceholder = Color(hex: "#B0B7C3")
      static let searchBorder = Color(hex: "#E8EBF0")
      static let primaryText = Color(hex: "#1D2433")
      static let serviceLabel = Color(hex: "#2D3444")
      static let heroButtonText = Color(hex: "#1E2331")
      static let secondaryText = Color(hex: "#7F8796")
      static let priceCaption = Color(hex: "#C5CAD4")
      static let chevronForeground = Color(hex: "#7E8695")
      static let chevronBackground = Color(hex: "#F4F6FA")
      static let roadGlow = Color(hex: "#A36D52")
    static let softAccentBackground = Color(hex: "#FFF3F4")
    static let heroGradientTop = Color(hex: "#5B463D")
        static let heroGradientBottom = Color(hex: "#10142A")

      private init(hex: String) {
          let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
          var int: UInt64 = 0
          Scanner(string: hex).scanHexInt64(&int)

          let a, r, g, b: UInt64
          switch hex.count {
          case 3:
              (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
          case 6:
              (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
          case 8:
              (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
          default:
              (a, r, g, b) = (255, 0, 0, 0)
          }

          self.init(
              .sRGB,
              red: Double(r) / 255,
              green: Double(g) / 255,
              blue: Double(b) / 255,
              opacity: Double(a) / 255
          )
      }
}
