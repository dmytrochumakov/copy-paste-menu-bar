//
//  TaskNumberListFeature.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 19.10.2023.
//

import Foundation
import ComposableArchitecture

struct TaskNumber: Equatable, Codable, Hashable {
    let number: String
}

@Reducer
struct TaskNumberListFeature {

    private let userDefaults: UserDefaults = .standard
    private let taskKey = "userDefaultsTaskKey"

    let closePopover: () -> Void

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addTaskNumber:
                state.taskNumbers.append(.init(number: "#\(state.taskNumber) - "))
                let encoded = try? JSONEncoder().encode(state.taskNumbers)
                userDefaults.set(encoded, forKey: taskKey)
                return .none
            case .copyTaskNumber(let index):
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
                guard
                    let data = userDefaults.object(forKey: taskKey) as? Data
                else {
                    return .none
                }
                state.taskNumbers = (try? JSONDecoder().decode([TaskNumber].self, from: data)) ?? []
                return .none
            case .delete(let index):
                state.taskNumbers.remove(at: index)
                let encoded = try? JSONEncoder().encode(state.taskNumbers)
                userDefaults.set(encoded, forKey: taskKey)
                return .none
            case .clearTaskNumberField:
                state.taskNumber = ""
                return .none
            case .taskNumberChanged(let newValue):
                state.taskNumber = newValue
                return .none            
            }
        }
    }

    struct State: Equatable {
        var taskNumbers: [TaskNumber]
        var taskNumber: String = ""
    }

    enum Action: Equatable {
        case addTaskNumber
        case copyTaskNumber(_ index: Int)
        case copyNumber(_ index: Int)
        case load
        case delete(_ index: Int)
        case clearTaskNumberField
        case taskNumberChanged(_ newValue: String)
    }

}
