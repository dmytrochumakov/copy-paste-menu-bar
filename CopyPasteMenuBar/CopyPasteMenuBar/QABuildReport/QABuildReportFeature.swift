//
//  QABuildReportFeature.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 23.10.2023.
//

import ComposableArchitecture
import AppKit

struct QABuildReportFeature: Reducer {

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .copy(let data):
                let pasteboard = NSPasteboard.general
                pasteboard.declareTypes([.string], owner: nil)
                pasteboard.setString(createQABuildReport(data), forType: .string)
                return .none
            }
        }
    }

    struct State: Equatable {

    }

    enum Action: Equatable {
        case copy(data: QABuildData)
    }

    private func createQABuildReport(_ data: QABuildData) -> String {
        let oneNewLine = "\n"
        let twoNewLines = "\n\n"
        return "ENV:"
        +
        oneNewLine
        +
        "\(data.enviroment.rawValue.uppercased())"
        +
        twoNewLines
        +
        "Firebase:"
        +
        oneNewLine
        +
        "\(data.firebaeLink)"
        +
        twoNewLines
        +
        "Azure:"
        +
        oneNewLine
        +
        "\(data.azureLink)"
    }

}
