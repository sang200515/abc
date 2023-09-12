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
        configureUIPopover()

        hotKey.keyDownHandler = {
            self.togglePopover(nil)
        }


    }

    private func configureUIPopover(){
        self.popOver = NSPopover()
        popOver!.contentSize = NSSize(width: 300, height: 500)
        popOver!.behavior = .transient
        popOver!.contentViewController = NSHostingController(rootView: contentView)
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        if let button = self.statusBarItem?.button {
            button.image = NSImage(systemSymbolName: "figure.badminton", accessibilityDescription: "Clipper Status Bar Button")
            button.action = #selector(togglePopover(_:))
            self.popOver!.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }

        if let window = NSApplication.shared.windows.first {
            window.close()
        }

        if let button = self.statusBarItem?.button {
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
    }
    @objc func handleOption1(_ sender: NSMenuItem) {
        print("oke")
    }

    @objc func handleOption2(_ sender: NSMenuItem) {
        print("oke2")
    }
    @objc func togglePopover(_ sender: AnyObject?) {
        guard let button = self.statusBarItem?.button else { return }
        if let event = NSApp.currentEvent {
            if event.type == .rightMouseUp {
                let menu = NSMenu()

                let quitMenuItem = NSMenuItem(title: "Quit", action: #selector(quitAction(_:)), keyEquivalent: "")
                menu.addItem(quitMenuItem)

                let somethingMenuItem = NSMenuItem(title: "Something", action: #selector(somethingAction(_:)), keyEquivalent: "")
                menu.addItem(somethingMenuItem)
                NSMenu.popUpContextMenu(menu, with: event, for: button) // please add padding of top 20 from top

            } else {
                if self.popOver!.isShown {
                    self.popOver!.performClose(sender)
                } else {
                    self.popOver!.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
                }
            }
        }
    }

    @objc func quitAction(_ sender: NSMenuItem) {
        NSApp.terminate(nil)
    }

    @objc func somethingAction(_ sender: NSMenuItem) {
        self.togglePopover(nil)
    }
}
