//
//  CodeImageView.swift
//  Sang's App
//
//  Created by Sang Truong on 10/09/2023.
//

import Foundation
import SwiftUI

struct CodeImageView: View {
    var body: some View {
        CodeImageView2()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct CodeImageView2: NSViewRepresentable {
    let code: String = AppData().getClipboardValue()

    func makeNSView(context: Context) -> NSTextView {
        let textView = NSTextView()

        textView.appearance = NSAppearance(named: .darkAqua)

        textView.font = NSFont.userFixedPitchFont(ofSize: 14.0)

        textView.backgroundColor = NSColor.textBackgroundColor
        textView.string = code

        return textView
    }

    func updateNSView(_ nsView: NSTextView, context: Context) {
        nsView.string = code
    }
}
