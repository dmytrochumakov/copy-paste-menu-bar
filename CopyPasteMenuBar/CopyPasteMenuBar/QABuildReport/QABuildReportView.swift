//
//  QABuildReportView.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 23.10.2023.
//

import SwiftUI
import ComposableArchitecture

struct QABuildReportView: View {

    var store: StoreOf<QABuildReportFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Form {
                Picker("Pick enviroment", selection: viewStore.binding(get: \.enviroment, send: { .enviromentChanged($0) })) {
                    ForEach(QABuildReportEnviroment.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                Group {
                    Text("Enter Firebae link")
                    TextField("", text: viewStore.binding(get: \.firebaeLink, send: { .firebaeLinkChanged($0) }))
                }
                Group {
                    Text("Enter Azure link")
                    TextField("", text: viewStore.binding(get: \.azureLink, send: { .azureLinkChanged($0) }))
                }
                Button("Copy") {
                    viewStore.send(.copy)
                }
            }
            .padding()
        }
    }

}

#Preview {
    QABuildReportView(store: Store(initialState: QABuildReportFeature.State()) {
        QABuildReportFeature()._printChanges()
    })
}
