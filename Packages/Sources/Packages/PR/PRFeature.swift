//
//  PRFeature.swift
//  CopyPasteMenuBar
//
//  Created Dmytro Chumakov on 08.01.2024.
//

import ComposableArchitecture

@Reducer
public struct PRFeature {
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

private extension PRFeature {
    static func text(_ link: String) -> String {
        "PR: \n\(link)"
    }
}
