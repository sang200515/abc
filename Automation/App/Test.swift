//
//  Test.swift
//  Sang's App
//
//  Created by Sang Truong on 10/09/2023.
//

import SwiftUI


public struct P238_LimitTextEditor: View {

    @State private var limitNumber: Int = 30
    @State private var baseText: String = "Text"

    public init() {}
    public var body: some View {
        let text = Binding(
            get: { self.baseText },
            set: { self.baseText = String($0.prefix(limitNumber)).components(separatedBy: .newlines).joined() }
        )
        VStack {
            Text("Number of characters : \(text.wrappedValue.count)")
                .foregroundColor(text.wrappedValue.count == limitNumber ? .red : .red)
            Rectangle()
                .fill(Color.green)
                .overlay(
                    TextEditor(text: $baseText)
                        .padding(2)
                        .border(Color(white: 0.8), width: 1)
                        .frame(minHeight: 100, maxHeight: 250)

                )
        }
        .padding()
    }
}

struct P238_LimitTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        P238_LimitTextEditor()
    }
}
