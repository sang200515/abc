//
//  Extension+View+Modifier.swift
//  Sang's App
//
//  Created by Sang Truong on 10/09/2023.
//

import Foundation
import SwiftUI

struct BackButtonOverlayModifier: ViewModifier {
    var action: () -> Void

    func body(content: Content) -> some View {
        content
            .overlay(
                Button(action: {
                    action()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundColor(.blue)
                },
                alignment: .topLeading
            )
    }
}

extension View {
    func backButtonOverlay(action: @escaping () -> Void) -> some View {
        self.modifier(BackButtonOverlayModifier(action: action))
    }
}
extension View {
  func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear
          .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
      }
    )
    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
  }
}

private struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
