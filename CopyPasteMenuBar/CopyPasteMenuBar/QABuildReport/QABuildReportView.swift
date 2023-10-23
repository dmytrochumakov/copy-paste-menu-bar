//
//  QABuildReportView.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 23.10.2023.
//

import SwiftUI
import ComposableArchitecture

struct QABuildReportView: View {

    @State private var enviroment = QABuildReportEnviroment.stage
    @State private var firebaeLink = ""
    @State private var azureLink = ""

    var store: StoreOf<QABuildReportFeature>

    var body: some View {
        Form {
            Picker("Pick enviroment", selection: $enviroment) {
                ForEach(QABuildReportEnviroment.allCases) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
            Group {
                Text("Enter Firebae link")
                TextField("", text: $firebaeLink)
            }
            Group {
                Text("Enter Azure link")
                TextField("", text: $azureLink)
            }
            Button("Copy") {
                store.send(.copy(data: QABuildData(enviroment: enviroment,
                                                   firebaeLink: firebaeLink,
                                                   azureLink: azureLink)))
            }
        }
        .padding()
    }



}

#Preview {
    QABuildReportView(store: Store(initialState: QABuildReportFeature.State()) {
        QABuildReportFeature()._printChanges()
    })
}
