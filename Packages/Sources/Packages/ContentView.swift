//
//  ContentView.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 12.10.2023.
//

import ComposableArchitecture
import SwiftUI

public struct ContentView: View {
    private let scrollTopID = "topId"
    private let appStore: AppStore

    public init(appStore: AppStore) {
        self.appStore = appStore
    }

    public var body: some View {
        VStack {
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            ScrollViewReader { reader in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack {
                        TaskNumberListView(store: appStore.taskListStore)
                            .id(scrollTopID)
                        PRView(store: appStore.prStore)
                        SwitchToAnotherTaskView(store: appStore.switchToAnotherTaskStore)
                        GitBranchNameView(store: appStore.gitBranchNameStore)
                        QABuildReportView(store: appStore.qaBuildReportStore)
                        CredentialsListView(store: appStore.credentialsListStore)
                    }
                }
                .overlay(alignment: .trailing) {
                    VStack {
                        Spacer()
                        Button {
                            withAnimation {
                                reader.scrollTo(scrollTopID, anchor: .top)
                            }
                        } label: {
                            Image(systemName: "arrow.up.circle")
                                .frame(width: 32, height: 32)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView(appStore: .mock)
}
