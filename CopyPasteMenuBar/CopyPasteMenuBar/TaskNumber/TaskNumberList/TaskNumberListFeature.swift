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

struct TaskNumberListFeature: Reducer {

    private let userDefaults: UserDefaults = .standard
    private let taskKey = "userDefaultsTaskKey"

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addTaskNumber(let number):
                state.taskNumbers.append(.init(number: "#\(number) - "))
                let encoded = try? JSONEncoder().encode(state.taskNumbers)
                userDefaults.set(encoded, forKey: taskKey)
                return .none
            case .copyTaskNumber(let number):
                copyToPasteboard(number)
                return .none
            case .load:
                guard
                    let data = userDefaults.object(forKey: taskKey) as? Data
                else {
                    return .none
                }
                state.taskNumbers = (try? JSONDecoder().decode([TaskNumber].self, from: data)) ?? []
                return .none
            case .delete(let taskNumber):
                state.taskNumbers.removeAll(where: { $0 == taskNumber })
                let encoded = try? JSONEncoder().encode(state.taskNumbers)
                userDefaults.set(encoded, forKey: taskKey)
                return .none
            }
        }
    }

    struct State: Equatable {
        var taskNumbers: [TaskNumber]
    }

    enum Action: Equatable {
        case addTaskNumber(_ number: String)
        case copyTaskNumber(_ number: String)
        case load
        case delete(_ taskNumber: TaskNumber)
    }

}
