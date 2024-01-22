//
//  AppDelegate.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 19.10.2023.
//

import ComposableArchitecture
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!

    func applicationDidFinishLaunching(_: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(systemSymbolName: "hammer.circle",
                                         accessibilityDescription: "Tool")
            statusButton.action = #selector(togglePopover)
        }
        popover = NSPopover()
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: ContentView(appStore: .init(closePopover: { [unowned self] in
            closePopover()
        })))
    }

    @objc private func togglePopover() {
        guard let statusButton = statusItem.button else { return }
        if popover.isShown {
            closePopover()
        } else {
            popover.show(relativeTo: statusButton.bounds, of: statusButton, preferredEdge: .minY)
        }
    }

    private func closePopover() {
        popover.performClose(nil)
    }
}
