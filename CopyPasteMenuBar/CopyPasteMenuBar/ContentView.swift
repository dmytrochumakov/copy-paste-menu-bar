//
//  ContentView.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 12.10.2023.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {

    var taskListStore: StoreOf<TaskNumberListFeature>
    var qaBuildReportStore: StoreOf<QABuildReportFeature>

    var body: some View {
        VStack {
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    TaskNumberListView(store: taskListStore)
                    QABuildReportView(store: qaBuildReportStore)
                }
            }
        }
    }

}

#Preview {
    ContentView(taskListStore: Store(initialState: TaskNumberListFeature.State(taskNumbers: [])) {
        TaskNumberListFeature()._printChanges()
    }, qaBuildReportStore: Store(initialState: QABuildReportFeature.State()) {
        QABuildReportFeature()._printChanges()
    })
}
