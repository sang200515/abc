//
//  AutomationApp.swift
//  Automation
//
//  Created by Sang Truong on 10/09/2023.
//

import SwiftUI
import AppKit
import Foundation
import HotKey

@main
struct AutomationApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 400, height: 500, alignment: .center)
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem?
    var popOver: NSPopover?
    let contentView = ContentView()
    let hotKey = HotKey(key: .space, modifiers: [ .option])

    func applicationDidFinishLaunching(_ notification: Notification) {
        self.popOver = NSPopover()
        popOver!.contentSize = NSSize(width: 300, height: 500)
        popOver!.behavior = .transient
        popOver!.contentViewController = NSHostingController(rootView: contentView)

        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))

        if let button = self.statusBarItem?.button {
            button.image = NSImage(systemSymbolName: "trash", accessibilityDescription: "Clipper Status Bar Button")
            button.action = #selector(togglePopover(_:))
            self.popOver!.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }

        if let window = NSApplication.shared.windows.first {
            window.close()
        }

        hotKey.keyDownHandler = {
            self.togglePopover(nil) // Fix: Remove `_:` when calling the method
        }
    }

    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = self.statusBarItem?.button {
            if self.popOver!.isShown {
                self.popOver!.performClose(sender)
            } else {
                self.popOver!.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
}
