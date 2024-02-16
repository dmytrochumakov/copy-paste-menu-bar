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
            case let .linkChanged(link):
                state.link = link
                return .none

            case .copy:
                copyToPasteboard(Self.text(state.link))
                state = State()
                closePopover()
                return .none
            }
        }
    }

    public struct State: Equatable {
        var link: String = ""
    }

    public enum Action: Equatable {
        case linkChanged(String)
        case copy
    }
}

// MARK: - Private

private extension SwitchToAnotherTaskFeature {
    static func text(_ link: String) -> String {
        "switched to task:\n\(link)"
    }
}
