//
//  QABuildReportFeature.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 23.10.2023.
//

import ComposableArchitecture
import Foundation

@Reducer
public struct QABuildReportFeature {
    let closePopover: () -> Void

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .enviromentChanged(let newValue):
                state.enviroment = newValue
                return .none
            case .firebaeLinkChanged(let newValue):
                state.firebaeLink = newValue
                return .none
            case .azureLinkChanged(let newValue):
                state.azureLink = newValue
                return .none
            case .copy:
                copyToPasteboard(createQABuildReport(
                    state.enviroment,
                    cleanUp(state.firebaeLink),
                    cleanUp(state.azureLink)
                ))
                closePopover()
                return .none
            case .simpleToastIsPresentedChanged(let newValue):
                state.simpleToastIsPresented = newValue
                return .none
            case .clearAzureLink:
                state.azureLink = ""
                return .none
            case .clearFirebaeLink:
                state.firebaeLink = ""
                return .none
            case .clearLinks:
                state.azureLink = ""
                state.firebaeLink = ""
                return .none
            }
        }
    }

    public struct State: Equatable {
        var enviroment = QABuildReportEnviroment.unknown
        var firebaeLink = ""
        var azureLink = ""
        var simpleToastIsPresented: Bool = false
    }

    public enum Action: Equatable {
        case enviromentChanged(_ newValue: QABuildReportEnviroment)
        case firebaeLinkChanged(_ newValue: String)
        case azureLinkChanged(_ newValue: String)
        case copy
        case simpleToastIsPresentedChanged(_ newValue: Bool)
        case clearAzureLink
        case clearFirebaeLink
        case clearLinks
    }

    private func createQABuildReport(
        _ enviroment: QABuildReportEnviroment,
        _ firebaeLink: String,
        _ azureLink: String
    ) -> String {
        let oneNewLine = "\n"
        let twoNewLines = "\n\n"
        return "ENV:"
            +
            oneNewLine
            +
            "\(enviroment.rawValue.uppercased())"
            +
            twoNewLines
            +
            "Firebase:"
            +
            oneNewLine
            +
            "\(firebaeLink)"
            +
            twoNewLines
            +
            "Azure:"
            +
            oneNewLine
            +
            "\(azureLink)"
    }
}

private extension QABuildReportFeature {
    func cleanUp(_ inputString: String) -> String {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            let matches = detector.matches(in: inputString, options: [], range: NSRange(location: 0, length: inputString.utf16.count))
            for match in matches {
                guard let range = Range(match.range, in: inputString),
                      let url = URL(string: String(inputString[range])) else { continue }
                print(url)
            }
            if matches.isEmpty {
                return inputString
            } else {
                return matches.first!.url!.absoluteString
            }
        } catch {
            return inputString
        }
    }
}
