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

    var body: some View {
        WithViewStore(store, observe: { $0.taskNumbers }) { viewStore in
            ForEach(viewStore.state, id: \.self) { taskNumber in
                HStack {
                    Text(String(taskNumber.number))
                    Spacer()
                    CopyTaskNumberView {
                        viewStore.send(.copyTaskNumber(taskNumber.number))
                    }
                    Button(action: {
                        viewStore.send(.delete(taskNumber))
                    }, label: {
                        Image(systemName: "trash")
                    })
                }
                .padding()
            }
            AddTaskNumberView { taskNumber in
                viewStore.send(.addTaskNumber(taskNumber))
            }
        }
        .onAppear {
            store.send(.load)
        }
    }

}

#Preview {
    TaskNumberListView(store: Store(initialState: TaskNumberListFeature.State(taskNumbers: [])) {
        TaskNumberListFeature()._printChanges()
    })
}
