//
//  AppData.swift
//  Sang's App
//
//  Created by Sang Truong on 10/09/2023.
//

import Foundation
import AppKit

class AppData {
    static let shared = AppData()

    func getClipboardValue() -> String {
        let pasteboard = NSPasteboard.general
            if let copiedString = pasteboard.string(forType: .string) {
                return copiedString
            } else {
                return "No value found in clipboard"
            }
        }

}
