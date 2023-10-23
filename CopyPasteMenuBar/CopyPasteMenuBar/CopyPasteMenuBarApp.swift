//
//  CopyPasteMenuBarApp.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 12.10.2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct CopyPasteMenuBarApp: App {

    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView(taskListStore: Store(initialState: TaskNumberListFeature.State(taskNumbers: [])) {
                TaskNumberListFeature()._printChanges()
            }, qaBuildReportStore: Store(initialState: QABuildReportFeature.State()) {
                QABuildReportFeature()._printChanges()
            })
        }
    }

}
