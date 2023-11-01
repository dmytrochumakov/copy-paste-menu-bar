//
//  GitBranchNameView.swift
//  CopyPasteMenuBar
//
//  Created Dmytro Chumakov on 01.11.2023.
//

import SwiftUI
import ComposableArchitecture

struct GitBranchNameView: View {

    let store: StoreOf<GitBranchNameFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Form {
                gitBranchTypePickerView(viewStore)
                gitBranchNumber(viewStore)
                gitBranchName(viewStore)
                copyButton
            }
            .padding()
        }
    }

}

// MARK: - Views
private extension GitBranchNameView {

    func gitBranchTypePickerView(_ viewStore: ViewStoreOf<GitBranchNameFeature>) -> some View {
        Picker("Pick branch type",
               selection: viewStore.binding(get: \.branchType,
                                            send: { .branchTypeChanged($0) })) {
            ForEach(GitBranchType.allCases, id: \.self) {
                Text($0.rawValue)
            }
        }.pickerStyle(.segmented)
    }

    func gitBranchNumber(_ viewStore: ViewStoreOf<GitBranchNameFeature>) -> some View {
        Group {
            Text("Branch number")
            TextField("", text: viewStore.binding(get: \.taskNumber,
                                                  send: { .taskNumberChanged($0) }))
        }
    }

    func gitBranchName(_ viewStore: ViewStoreOf<GitBranchNameFeature>) -> some View {
        Group {
            Text("Branch name")
            TextField("", text: viewStore.binding(get: \.branchName,
                                                  send: { .branchNameChanged($0) }))
        }
    }

    var copyButton: some View {
        Button {
            store.send(.copy)
            store.send(.resetState)
        } label: {
            Text("Copy")
        }
    }

}

#Preview {
    GitBranchNameView.mock
}
