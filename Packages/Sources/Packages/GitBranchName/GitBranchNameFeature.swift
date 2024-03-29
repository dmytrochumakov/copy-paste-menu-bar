//
//  GitBranchNameFeature.swift
//  CopyPasteMenuBar
//
//  Created Dmytro Chumakov on 01.11.2023.
//

import ComposableArchitecture
import Foundation

@Reducer
public struct GitBranchNameFeature {
    let closePopover: () -> Void

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .branchTypeChanged(newValue):
                state.branchType = newValue
                return .none
            case let .taskNumberChanged(newValue):
                state.taskNumber = newValue
                return .none
            case let .branchNameChanged(newValue):
                state.branchName = newValue
                return .none
            case .copy:
                copyToPasteboard(buildResult(state))
                closePopover()
                return .none
            case .resetState:
                state = State()
                return .none
            }
        }
    }

    public struct State: Equatable {
        var branchType = GitBranchType.unknown
        var taskNumber = ""
        var branchName = ""
    }

    public enum Action: Equatable {
        case branchTypeChanged(_ newValue: GitBranchType)
        case taskNumberChanged(_ newValue: String)
        case branchNameChanged(_ newValue: String)
        case copy
        case resetState
    }

    private func buildResult(_ state: State) -> String {
        "\(state.branchType.rawValue)"
            + "/"
            + "\(taskType(state.branchType))"
            + "-"
            + "\(state.taskNumber)"
            + "-"
            + "\(state.branchName.lowerKebabCased)"
    }

    private func taskType(_ branchType: GitBranchType) -> String {
        switch branchType {
        case .feature:
            "task"
        case .bugfix:
            "bug"
        case .unknown:
            ""
        }
    }
}

/*
 source
 - https://gist.github.com/adamgraham/79d4f86fdc36601e564fd3625a8687d2
 */
/// An extension to format strings in *kebab case*.
extension String {
    /// A collection of all the words in the string by separating out any punctuation and spaces.
    var words: [String] {
        components(separatedBy: CharacterSet.alphanumerics.inverted).filter { !$0.isEmpty }
    }

    /// Returns a lowercased copy of the string with punctuation removed and spaces replaced
    /// by a single hyphen, e.g., "the-quick-brown-fox-jumps-over-the-lazy-dog".
    ///
    /// *Lower kebab case* (or, illustratively, *kebab-case*) is also known as *spinal case*,
    /// *param case*, *Lisp case*, and *dash case*.
    var lowerKebabCased: String {
        words.map { $0.lowercased() }.joined(separator: "-")
    }
}
