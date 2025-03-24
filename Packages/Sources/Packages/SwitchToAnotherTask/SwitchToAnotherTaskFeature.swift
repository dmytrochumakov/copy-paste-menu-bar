//
//  SwitchToAnotherTaskFeature.swift
//  CopyPasteMenuBar
//
//  Created Dmytro Chumakov on 08.01.2024.
//

import ComposableArchitecture

@Reducer
public struct SwitchToAnotherTaskFeature {
    let closePopover: () -> Void

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .taskNumberChanged(taskNumber):
                state.taskNumber = taskNumber
                return .none

            case .copy:
                copyToPasteboard(Self.text(state.taskNumber))
                state = State()
                closePopover()
                return .none
            }
        }
    }

    public struct State: Equatable {
        var taskNumber: String = ""
    }

    public enum Action: Equatable {
        case taskNumberChanged(String)
        case copy
    }
}

// MARK: - Private

private extension SwitchToAnotherTaskFeature {
    static func text(_ taskNumber: String) -> String {
        let link = "https://dev.azure.com/competommc/Marketplace/_workitems/edit/\(taskNumber)"
        return "switched to task:\n\(link)"
    }
}
