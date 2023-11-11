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
                    Text("Enter Azure link")
                    let azureLink = viewStore.binding(get: \.azureLink, send: { .azureLinkChanged($0) })
                    TextField("", text: azureLink)
                        .modifier(TextFieldClearButtonModifier(text: azureLink, 
                                                               clearButtonTapped: {
                            viewStore.send(.clearAzureLink)
                        }))
                }
                Group {
                    Text("Enter Firebae link")
                    let firebaeLink = viewStore.binding(get: \.firebaeLink, send: { .firebaeLinkChanged($0) })
                    TextField("", text: firebaeLink)
                        .modifier(TextFieldClearButtonModifier(text: firebaeLink,
                                                               clearButtonTapped: {
                            viewStore.send(.clearFirebaeLink)
                        }))
                }
                Button("Copy") {
                    viewStore.send(.copy)
                    viewStore.send(.clearLinks)
                }
            }
            .padding()
        }
    }

}

#Preview {
    QABuildReportView(store: Store(initialState: QABuildReportFeature.State()) {
        QABuildReportFeature(closePopover: {})._printChanges()
    })
}
