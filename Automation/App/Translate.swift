//
//  Translate.swift
//  Sang's App
//
//  Created by Sang Truong on 10/09/2023.
//

import Foundation
import SwiftUI
import ScriptingBridge
import Combine

struct TranslationView: View {
    @Environment(\.openURL) var openURL
    @State private var inputText = AppData().getClipboardValue()
    @State private var translatedText = ""
    var action:(() -> Void)
    var body: some View {
        VStack {
//            TextEditor(text: $inputText)
//                .cornerRadius(12)
//                .padding()
//
//            Text(AppData().getClipboardValue())
//            Button(action: {
//                guard let url = URL(string: "https://translate.google.com/?hl=vi&sl=auto&tl=en&text=expression&op=translate") else { return }
//                openURL(url)
//            }) {
//                Text(verbatim: "Dịch")
//            }
//            .keyboardShortcut(.defaultAction)


        } .onAppear {
            guard let url = URL(string: "https://translate.google.com/?hl=vi&sl=auto&tl=en&text=&op=translate") else { return }
            openURL(url)
            action()
        }
    }

    func runAppleScript() {
        let scriptSource = """
        tell application "Google Chrome"
            if not (exists (window 1)) then
                activate
                open location "https://translate.google.com/?hl=vi&sl=auto&tl=en&text=expression&op=translate"
            else
                activate
                make new window
                set URL of active tab of window 1 to "https://translate.google.com/?hl=vi&sl=auto&tl=en&text=expression&op=translate"
            end if
        end tell
        """

        var error: NSDictionary?
        if let script = NSAppleScript(source: scriptSource) {
            script.executeAndReturnError(&error)
        }

        if let error = error {
            print("Error: \(error)")
        }
    }
}
struct TranslationResponse: Decodable {
    let translation: String
}
