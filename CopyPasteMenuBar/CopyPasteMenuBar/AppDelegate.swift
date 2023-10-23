//
//  AppDelegate.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 19.10.2023.
//

import AppKit
import SwiftUI
import ComposableArchitecture

final class AppDelegate: NSObject, NSApplicationDelegate {

    private var statusItem: NSStatusItem!
    private var popover: NSPopover!

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(systemSymbolName: "hammer.circle",
                                         accessibilityDescription: "Tool")
            statusButton.action = #selector(togglePopover)
        }
        popover = NSPopover()
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: ContentView(taskListStore: Store(initialState: TaskNumberListFeature.State(tasks: [])) {
            TaskNumberListFeature()._printChanges()
        }, qaBuildReportStore: Store(initialState: QABuildReportFeature.State()) {
            QABuildReportFeature()._printChanges()
        }))
    }

    @objc private func togglePopover() {
        guard let statusButton = statusItem.button else { return }
        if popover.isShown {
            popover.performClose(nil)
        } else {
            popover.show(relativeTo: statusButton.bounds, of: statusButton, preferredEdge: .minY)
        }
    }

}
