//
//  JsonFormatView.swift
//  Sang's App
//
//  Created by Sang Truong on 10/09/2023.
//

import Foundation
import SwiftUI

struct JsonFormatView: View {
    @State private var jsonString: String = "\n"
    @State private var formattedJSON: String = ""
    @State private var showAlert: Bool = false
    @State private var titleCopyButton: String = "Copy"
    @FocusState private var isTextFieldActive: Bool
    var action:(() -> Void)

    var body: some View {
        VStack {

            Text("JSON Formatter")
                .font(.title)
                .padding()

            Text("Enter JSON")
                .font(.headline)
                .padding(.top)

            TextEditor(text: $jsonString)
                .cornerRadius(12)
                .frame(height: 250)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                }
                .onAppear {
                    DispatchQueue.main.async {
                        isTextFieldActive = true
                    }
                }
                .focused($isTextFieldActive)


            Button("Format JSON") {
                formatJSON()
                titleCopyButton = "Copy"
            }
            .keyboardShortcut(.defaultAction)
            .padding()

            Text("Formatted JSON")
                .font(.headline)
                .padding(.top)



            TextEditor(text: $formattedJSON)
                .cornerRadius(10)
                .frame(height: 250)
                .font(.system(size: 14))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                }
                .overlay(alignment: .topTrailing) {
                    Button(titleCopyButton) {
                        titleCopyButton = "Copied"
                        copyToClipboard()
                    }
                    .keyboardShortcut("c", modifiers: .command)
                    .padding()
                }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Invalid JSON"),
                message: Text("The entered JSON is invalid. Please check the syntax and try again."),
                dismissButton: .default(Text("OK"))
            )
        }
        .backButtonOverlay {
            action()
        }
        .padding()
        .keyboardShortcut(.cancelAction)
    }

    func formatJSON() {
        let jsonData = jsonString.data(using: .utf8)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        do {
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData!, options: [])
            let formattedData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            let formattedString = String(data: formattedData, encoding: .utf8)
            formattedJSON = formattedString ?? "Invalid JSON"
            showAlert = false
        } catch {
            formattedJSON = "Invalid JSON"
            showAlert = true
        }
    }

    func copyToClipboard() {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(formattedJSON, forType: .string)
    }
}

struct JsonFormatView_Previews: PreviewProvider {
    static var previews: some View {
        JsonFormatView { }
    }
}
