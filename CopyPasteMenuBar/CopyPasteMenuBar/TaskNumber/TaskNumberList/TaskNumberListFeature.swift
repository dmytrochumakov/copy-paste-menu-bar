//
//  TaskNumberListFeature.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 19.10.2023.
//

import ComposableArchitecture
import AppKit

struct TaskNumber: Equatable, Identifiable, Codable {

    var id: String {
        number
    }

    let number: String

}

struct TaskNumberListFeature: Reducer {

    private let userDefaults: UserDefaults = .standard
    private let taskKey = "userDefaultsTaskKey"

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addTask(let number):
                state.tasks.append(.init(number: "#\(number) - "))
                let encoded = try? JSONEncoder().encode(state.tasks)
                userDefaults.set(encoded, forKey: taskKey)
                return .none
            case .copyTask(let number):
                let pasteboard = NSPasteboard.general
                pasteboard.declareTypes([.string], owner: nil)
                pasteboard.setString(number, forType: .string)
                return .none
            case .load:
                guard
                    let data = userDefaults.object(forKey: taskKey) as? Data
                else {
                    return .none
                }
                state.tasks = (try? JSONDecoder().decode([TaskNumber].self, from: data)) ?? []
                return .none
            }
        }
    }

    struct State: Equatable {
        var tasks: [TaskNumber]
    }

    enum Action: Equatable {
        case addTask(number: String)
        case copyTask(number: String)
        case load
    }

}
