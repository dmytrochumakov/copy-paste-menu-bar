//
//  TaskNumberListFeature.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 19.10.2023.
//

import ComposableArchitecture
import Foundation
import AppKit

struct TaskNumber: Equatable, Codable, Hashable {
    let number: String
}

@Reducer
public struct TaskNumberListFeature {
    private let userDefaults: UserDefaults = .standard
    private let taskKey = "userDefaultsTaskKey"

    let closePopover: () -> Void

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addTaskNumber:
                state.taskNumbers.append(.init(number: "#\(state.taskNumber) - "))
                let encoded = try? JSONEncoder().encode(state.taskNumbers)
                userDefaults.set(encoded, forKey: taskKey)
                return .none
            case let .copyTaskNumber(index):
                copyToPasteboard(state.taskNumbers[index].number)
                closePopover()
                return .none
            case let .copyNumber(index):
                let replacedSymbol0 = state.taskNumbers[index].number.replacingOccurrences(of: "#", with: "")
                let replacedSymbol1 = replacedSymbol0.replacingOccurrences(of: "-", with: "")
                let result = replacedSymbol1.replacingOccurrences(of: " ", with: "")
                copyToPasteboard(result)
                closePopover()
                return .none
            case .load:
                guard let data = userDefaults.object(forKey: taskKey) as? Data
                else {
                    return .none
                }
                state.taskNumbers = (try? JSONDecoder().decode([TaskNumber].self, from: data)) ?? []
                return .none
            case let .delete(index):
                state.taskNumbers.remove(at: index)
                let encoded = try? JSONEncoder().encode(state.taskNumbers)
                userDefaults.set(encoded, forKey: taskKey)
                return .none
            case .clearTaskNumberField:
                state.taskNumber = ""
                return .none
            case let .taskNumberChanged(newValue):
                state.taskNumber = newValue
                return .none

            case let .linkTapped(index):                
                let number = state.taskNumbers[index].number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                let url = URL(string: "https://dev.azure.com/competommc/Marketplace/_workitems/edit/\(number)/")!
                NSWorkspace.shared.open(url)
                return .none
            }
        }
    }

    public struct State: Equatable {
        var taskNumbers: [TaskNumber]
        var taskNumber: String = ""
    }

    public enum Action: Equatable {
        case addTaskNumber
        case copyTaskNumber(_ index: Int)
        case copyNumber(_ index: Int)
        case load
        case delete(_ index: Int)
        case clearTaskNumberField
        case taskNumberChanged(_ newValue: String)
        case linkTapped(_ index: Int)
    }
}
