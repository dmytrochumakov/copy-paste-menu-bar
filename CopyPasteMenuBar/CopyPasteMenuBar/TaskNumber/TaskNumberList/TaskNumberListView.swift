//
//  TaskNumberListView.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 19.10.2023.
//

import SwiftUI
import ComposableArchitecture

struct TaskNumberListView: View {

    var store: StoreOf<TaskNumberListFeature>
    var qaBuildReportStore: StoreOf<QABuildReportFeature>

    var body: some View {
        WithViewStore(store, observe: { $0.tasks }) { viewStore in
            ForEach(viewStore.state) { task in
                HStack {
                    Text(String(task.number))
                    Spacer()
                    CopyTaskNumberView {
                        store.send(.copyTask(number: task.number))
                    }
                }
                .padding()
            }
            AddTaskNumberView { taskNumber in
                store.send(.addTask(number: taskNumber))
            }
            QABuildReportView(store: qaBuildReportStore)
        }
        .onAppear {
            store.send(.load)
        }
    }

}

#Preview {
    TaskNumberListView(store: Store(initialState: TaskNumberListFeature.State(tasks: [])) {
        TaskNumberListFeature()._printChanges()
    }, qaBuildReportStore: Store(initialState: QABuildReportFeature.State()) {
        QABuildReportFeature()._printChanges()
    })
}
