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
        WithViewStore(store, observe: { $0 }) { viewStore in
            ForEach(viewStore.taskNumbers.indices, id: \.self) { index in
                HStack {
                    taskNumberView(viewStore.taskNumbers[index].number)
                    Spacer()
                    HStack {
                        Button("Copy number") {
                            viewStore.send(.copyNumber(index))
                        }
                        CopyTaskNumberView {
                            viewStore.send(.copyTaskNumber(index))
                        }
                    }
                    deleteTaskNumberButton(at: index)
                }
                .padding()
            }
            AddTaskNumberView(taskNumber: viewStore.binding(get: \.taskNumber, send: { .taskNumberChanged($0) })) {
                viewStore.send(.addTaskNumber)
                viewStore.send(.clearTaskNumberField)
            } clearButtonTapped: {
                viewStore.send(.clearTaskNumberField)
            }
        }
        .onAppear {
            store.send(.load)
        }
        .onKeyPress(.return) {
            store.send(.addTaskNumber)
            store.send(.clearTaskNumberField)
            return .ignored
        }
    }

}

// MARK: - Views
private extension TaskNumberListView {

    func taskNumberView(_ number: String) -> some View {
        Text(number)
    }

    func deleteTaskNumberButton(at index: Int) -> some View {
        Button(action: {
            store.send(.delete(index))
        }, label: {
            Image(systemName: "trash")
        })
    }

}

#Preview {
    TaskNumberListView(store: Store(initialState: TaskNumberListFeature.State(taskNumbers: [])) {
        TaskNumberListFeature(closePopover: {})._printChanges()
    })
}
