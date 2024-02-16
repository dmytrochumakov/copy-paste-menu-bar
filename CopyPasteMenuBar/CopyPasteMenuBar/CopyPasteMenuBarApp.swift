//
//  CopyPasteMenuBarApp.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 12.10.2023.
//

import Packages
import SwiftUI

@main
struct CopyPasteMenuBarApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView(appStore: .init(closePopover: {}))
        }
    }
}
