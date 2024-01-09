//
//  SwitchToAnotherTaskView.swift
//  CopyPasteMenuBar
//
//  Created Dmytro Chumakov on 08.01.2024.
//

import SwiftUI
import ComposableArchitecture

struct SwitchToAnotherTaskView: View {

    let store: StoreOf<SwitchToAnotherTaskFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            HStack {
                TextField("Task link:", text: viewStore.binding(get: \.link, 
                send: {.linkChanged($0) }))
                Button("Copy") {
                    viewStore.send(.copy)
                }
            }.padding()
        }
        .onKeyPress(.return) {
            store.send(.copy)
            return .ignored
        }
    }

}

#Preview {
    SwitchToAnotherTaskView.mock
}
