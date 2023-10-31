//
//  ContentView.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 12.10.2023.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {

    let appStore: AppStore

    var body: some View {
        VStack {
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    TaskNumberListView(store: appStore.taskListStore)
                    QABuildReportView(store: appStore.qaBuildReportStore)
                    CredentialsListView(store: appStore.credentialsListStore)
                }
            }
        }
    }

}

#Preview {
    ContentView(appStore: .mock)
}
