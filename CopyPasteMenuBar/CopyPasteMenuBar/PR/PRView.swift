//
//  PRView.swift
//  CopyPasteMenuBar
//
//  Created Dmytro Chumakov on 08.01.2024.
//

import ComposableArchitecture
import SwiftUI

struct PRView: View {
    let store: StoreOf<PRFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            HStack {
                TextField("PR link:", text: viewStore.binding(get: \.link,
                                                              send: { .linkChanged($0) }))
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
    PRView.mock
}
