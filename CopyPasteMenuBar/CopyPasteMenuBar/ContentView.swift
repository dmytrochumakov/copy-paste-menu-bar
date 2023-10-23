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
        VStack(alignment: .leading,
               spacing: .zero) {
            TaskNumberListView(store: taskListStore,
                               qaBuildReportStore: qaBuildReportStore)
        }
               .frame(width: 300, height: 300)
    }

}

#Preview {
    ContentView(taskListStore: Store(initialState: TaskNumberListFeature.State(tasks: [])) {
        TaskNumberListFeature()._printChanges()
    }, qaBuildReportStore: Store(initialState: QABuildReportFeature.State()) {
        QABuildReportFeature()._printChanges()
    })
}
